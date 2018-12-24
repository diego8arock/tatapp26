class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_required
  layout 'admin'

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
      session[:text_errors] = []
      import_file = params[:employees_file]
      File.foreach( import_file.path ).with_index do |line, index|
        begin
          # number|name|joindate|birthdate|assignment|project|seat(optional)
          total += 1
          #Ommits header 
          if total == 1
            session[:text_errors][0] = line
            next
          end

          fields = line.split(";")

          if fields[0].blank? || fields[1].blank? || fields[2].blank? ||
            fields[3].blank? || fields[4].blank? || fields[5].blank?
              session[:text_errors][error_number] = line + ";" + I18n.t("errors.empty_line")
              error_number += 1
              logger.warn "Any field can be empty: #{line}"
              next
          end

          number = fields[0].strip
          name = fields[1].strip
          joindate = fields[2].strip
          birthdate = fields[3].strip
          assignment = fields[4].strip.downcase == "fijo" ? Employee::FIXED : Employee::MOBILE
          project_tag = fields[5].strip
          seat_code = fields[6].strip

          if assignment == Employee::FIXED && seat_code.blank?
            session[:text_errors][error_number] = line + ";" + I18n.t("errors.seat_mandatory")
            error_number += 1
            logger.warn "Seat code mandatory when assgnment type is fixed"
            next            
          end

          project = Project.find_by_tag(project_tag)
          if project.nil?
            session[:text_errors][error_number] = line + ";" + I18n.t("errors.project_not_exists")
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
              assignment_type: assignment,
              project: project)
          else
            if !user.is_employee?
              session[:text_errors][error_number] = line + ";" + I18n.t("errors.isnt_employee")
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
              assignment_type: assignment,
              project: project)
          end

          if !seat_code.blank?
            # seat_code = project_tag + seat_code
            seat = Seat.where(code: seat_code, project: project, status: Seat::ACTIVE).order(created_at: :desc).first
            if seat.nil?
              session[:text_errors][error_number] = line + ";" + I18n.t("errors.seat_not_exists")
              error_number += 1
              logger.warn "Seat with code #{seat_code} and project #{project_tag} doesn't exist"
              next
            else
              seat.update(status: Seat::UNAVAILABLE, assignment_date: Date.today )
              employee.update(seat: seat)
            end
          end

          ok_number += 1

        rescue => exception
          session[:text_errors][error_number] = line + ";" + I18n.t("errors.exception_load", {:exception => exception.message})
          error_number += 1
          logger.warn "There was a problem importing employees file.#{exception.message}"
        end
      end

      if error_number > 0
        session[:text_errors][error_number] = I18n.t("errors.errors_load", {:ok_number => ok_number, :error_number => error_number})
        flash[:error] = I18n.t("errors.errors_load", {:ok_number => ok_number, :error_number => error_number})
        raise ActiveRecord::Rollback, "Call tech support!"
      else
        session[:text_errors] = nil
        flash[:success] = I18n.t("ok_load", {:ok_number => ok_number} )
      end
    end

    redirect_to loademployees_path
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
    	  user = User.create(username: @employee.number,
    					    password: @employee.number,
    					    password_confirmation: @employee.number)
        user.add_role(:employee)
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
    respond_to do |format|
      if @employee.update(employee_params)
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

  def download_csv
    send_file(
      "#{Rails.root}/public/employee_template.csv",
      filename: "employee_template.csv",
      type: "text/csv"
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:id, :name, :number, :admission_date, :birth_date, :status, :assignment_type, :seat_id, :project_id)
    end    

    def generate_csv(text_array)
      Prawn::Document.new do
        text_array.each do |line| 
          text line, align: :left
        end
      end.render
    end
end
