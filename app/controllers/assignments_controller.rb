class AssignmentsController < ApplicationController

  def index
    @seats = []
    @seat = nil
    @assignment = Assignment.new
    project_employees = ProjectEmployee.where(:id_employee => current_user.id).where(:status => ProjectEmployee::ACTIVE)
    assignments = Assignment.includes(:seat).where("id_project_employee IN (?)",project_employees.map(&:id) )
                              .where(:status => Assignment::ACTIVE)
                              .where(:assignment_date => Date.today)
    @assigned = !assignments.empty?
    if @assigned
      @seat = assignments[0].seat
    else
      @seats = Seat.where("assignment_date IS NULL OR assignment_date <> ?", Date.today)
                    .where("id_project IN (?)",project_employees.map(&:id_project) )
                    .where(:status => Seat::ACTIVE)
    end
  end

  # GET /asignments/new
  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end
end
