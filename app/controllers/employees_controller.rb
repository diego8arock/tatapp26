class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_required

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # GET /employees/load
  def load
  end

  # POST /employees/save_load
  def save_load
    ActiveRecord::Base.transaction do
      Employee.update_all status: Employee::INACTIVE
      Seat.where(:status => Seat::UNAVAILABLE).update_all(status: Seat::ACTIVE, assignment_date: nil)
      ok_number = 0
      error_number = 0
      total = 0
      import_file = params[:employees_file]
      File.foreach( import_file.path ).with_index do |line, index|
        begin
          # number|name|joindate|birthdate|assignment|project|seat(optional)
          total += 1
          next if total == 1
          fields = line.split(";")

          number = fields[0]
          name = fields[1]
          joindate = fields[2]
          birthdate = fields[3]
          assignment = fields[4] == "Fijo" ? Employee::FIXED : Employee::MOBILE
          project_tag = fields[5]
          seat_code = fields[6]

          if number.blank? || name.blank? || joindate.blank? ||
            birthdate.blank? || assignment.blank? || project_tag.blank?
              error_number += 1
              logger.warn "Any field can be empty: #{line}"
              next
          end

          project = Project.find_by_tag(project_tag)
          if project.nil?
            error_number += 1
            logger.warn "Project tag #{project_tag} doesn't exist"
            next
          end

          #User
          user = User.find_by_username(number)
          if user.nil?
            user = User.create(username: number,
                        password: number,
                        password_confirmation: number)
            user.add_role(:employee)

            #Employee
            employee = Employee.create(number: number,
              name: name,
              birth_date: birthdate.to_date,
              admission_date: joindate.to_date,
              status: Employee::ACTIVE,
              assignment_type: assignment)

          	#Project employee
          	ProjectEmployee.create(
          		employee: employee,
          		project: project,
          		status: ProjectEmployee::ACTIVE
          	)
          else
            if !user.is_employee?
              error_number += 1
              logger.warn "User #{number} isn't employee"
              next
            end
            #Employee
            employee = Employee.find_by_number(number)
            employee.update(
              number: number,
              name: name,
              birth_date: birthdate.to_date,
              admission_date: joindate.to_date,
              status: Employee::ACTIVE,
              assignment_type: assignment)

          	#Project employee
            project_employee = ProjectEmployee.find_by employee: employee, project: project

            if project_employee.nil?
            	ProjectEmployee.create(
            		employee: employee,
            		project: project,
            		status: ProjectEmployee::ACTIVE
            	)
            else
            	project_employee.update(
            		status: ProjectEmployee::ACTIVE
            	)
            end
          end

          if !seat_code.blank?
            seat = Seat.find_by code: seat_code, project: project
            if seat.nil?
              error_number += 1
              logger.warn "Seat with code #{seat_code} and project #{project_tag} doesn't exist"
              next
            else
              seat.update(status: Seat::UNAVAILABLE, date_assignment: Date.today )
              employee.update(seat: seat)
            end
          end

          ok_number += 1

        rescue => exception
          error_number += 1
          logger.warn "There was a problem importing employees file.#{exception.message}"
        end
      end

      if error_number > 0
        flash[:error] = "#{ok_number} Employees without errors!...
                        #{error_number} Employees with errors!...
                        Please load the file again"
      else
        flash[:success] = "<strong>#{ok_number} Employees Imported!</strong>>"
      end
    end

    redirect_to loademployees_path
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    project = Project.find(params[:project][:id])

    respond_to do |format|
      if @employee.save
    	  user = User.create(username: @employee.number,
    					    password: @employee.number,
    					    password_confirmation: @employee.number)
        user.add_role(:employee)
        ProjectEmployee.create(
          employee: @employee,
          project: project,
          status: ProjectEmployee::ACTIVE
        )
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    project = Project.find(params[:project][:id])
    project_employee = ProjectEmployee.find_by employee: @employee, project: project

    respond_to do |format|
      if @employee.update(employee_params)
        ProjectEmployee.find_by_employee(employee).update_all(status: ProjectEmployee::INACTIVE)
        if project_employee.nil?
          ProjectEmployee.create(
            employee: @employee,
            project: project,
            status: ProjectEmployee::ACTIVE
          )
        else
          project_employee.update(
            status: ProjectEmployee::ACTIVE
          )
        end
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:id, :name, :number, :admission_date, :birth_date, :status, :assignment_type, :seat_id)
    end
end
