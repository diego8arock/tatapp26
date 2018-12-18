class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :employee_required
  layout 'assignment'

  def index
  end

  # GET /asignments/new
  def new
    get_map_info
  end

  def create
    seat = Seat.find(params[:seat_id])
    seat.assignment_date = Date.today
    seat.save!
    @assignment = Assignment.new
    @assignment.project= Project.find(session[:project_id])
    @assignment.employee= current_user.employee
    @assignment.seat = seat
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
      seat = assignment.seat
      seat.assignment_date = nil
      seat.save!
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

  def image
    get_map_info
  end

  private
    def get_map_info
      @map = Map.where(:project_id => session[:project_id]).last
      if !@map.nil?
        project = Project.find(session[:project_id])
        @available_seats = Seat.where("(assignment_date IS NULL OR assignment_date <> ?)", Date.today)
                      .where(:project => project)
                      .where(:status => Seat::ACTIVE)
                      .where(:map => @map)
        @unavailable_seats = Seat.where("(assignment_date = ? OR status <> ?)", Date.today, Seat::ACTIVE)
                      .where(:project => project)
                      .where(:map => @map)
        @seat = nil
        @mobile = current_user.employee.assignment_type == Employee::MOBILE

        if @mobile
          assignments = Assignment.includes(:seat).where(:project => project)
                                    .where(:employee => current_user.employee)
                                    .where(:status => Assignment::ACTIVE)
                                    .where(:assignment_date => Date.today)
          @assigned = !assignments.empty?
          if @assigned
            @assignment = assignments[0]
            @seat = @assignment.seat
          else
            @assignment = Assignment.new
          end
        else
          @seat = Seat.find(current_user.employee.seat_id)
        end
      else 
        flash[:error] = I18n.t "errors.no_map"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:id, :seat, :project, :employee, :status, :assignment_date)
    end
end
