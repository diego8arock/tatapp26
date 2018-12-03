class AssignmentsController < ApplicationController
  before_action :login_required
  layout 'assignment'

  def index
  end

  # GET /asignments/new
  def new
    @seats = []
    @seat = nil
    @mobile = current_user.assignment_type == Employee::MOBILE

    if @mobile
      project_employees = ProjectEmployee.where(:id_employee => current_user.id).where(:status => ProjectEmployee::ACTIVE)
      @project_employee = project_employees[0]
      assignments = Assignment.includes(:seat).where("id_project_employee IN (?)",project_employees.map(&:id) )
                                .where(:status => Assignment::ACTIVE)
                                .where(:assignment_date => Date.today)
      @assigned = !assignments.empty?
      if @assigned
        @assignment = assignments[0]
      else
        @seats = Seat.where("assignment_date IS NULL OR assignment_date <> ?", Date.today)
                      .where("id_project IN (?)",project_employees.map(&:id_project) )
                      .where(:status => Seat::ACTIVE)
        @assignment = Assignment.new
      end
    else
      @seat = Seat.find(current_user.id_seat)
    end
  end

  def create
    @assignment = Assignment.new
    @assignment.project_employee = ProjectEmployee.find(params[:project_employee])
    @assignment.seat = Seat.find(params[:seat_id])
    @assignment.assignment_date = Date.today
    @assignment.status = Assignment::ACTIVE

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: I18n.t("assignment.assignment_created") }
        format.json { render json: @assignment, :include => {:seat => {:only => :code}}, :except => [:created_at, :updated_at] }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    begin
      assignment = Assignment.find(params[:id])
      assignment.update(status: Assignment::INACTIVE)
      respond_to do |format|
        format.html { render :new }
        format.json { render(json: assignment, :include => {:seat => {:only => :code}}, :except => [:created_at, :updated_at] ) }
      end
    rescue Exception => e
      logger.info "Error en cancel " + e.message
      logger.error $!.backtrace
      return render :status => 500, :text => t('errors.cancel')
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:id, :seat, :project_employee, :status, :assignment_date)
    end
end
