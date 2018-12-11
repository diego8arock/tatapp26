class SeatsController < ApplicationController
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_required
  layout 'admin'

  # GET /seats
  # GET /seats.json
  def index
    @seats = Seat.all
  end

  # GET /seats/1
  # GET /seats/1.json
  def show
  end

  # GET /seats/new
  def new
    if params[:actionToDo].present?
      case params[:actionToDo]
      when 'search'
        # Buscar el asiento sin html_id
        @seats = Seat.where(project_id: params[:project_id], map_id: params[:map_id], code: params[:code])
        @codigoNuevo = @seats.empty?
        if @codigoNuevo
          # Retorna vacio en caso que no exista
          @seat = Seat.where(project_id: params[:project_id], map_id: params[:map_id], html_id: params[:html_id]).first
        else
          @seat = @seats.first
          if params[:fixed] == @seat.fixed.to_s
            @seat = "El asiento ya existe en otra posición con el mismo nombre."
          end
        end
      when 'insert'
        # Insertar nuevo asiento
        @seat = Seat.new(project_id: params[:project_id], map_id: params[:map_id], html_id: params[:html_id], code: params[:code], fixed: params[:fixed])
        if !@seat.save
          logger.debug @seat.errors.full_messages
        end
      when 'update'
        # Actualizar el asiento
        @seat = Seat.find(params[:id])
        @seat.update(project_id: params[:project_id], map_id: params[:map_id], html_id: params[:html_id], code: params[:code], fixed: params[:fixed])
      when 'map'
        @seat = Seat.where(project_id: params[:project_id], map_id: params[:map_id])
      end
      if request.xhr?
        respond_to do |format|
          format.json {
            render json: {seat: @seat}
          }
        end
      end
    else
      @seat = Seat.new
    end
  end

  # GET /seats/1/edit
  def edit
  end

  def assign
    logger.debug "Assign get method"
    if params[:actionToDo].present?
      case params[:actionToDo]
      when 'employees'
        @project = Project.find( params[:project_id])
        @employess = @project.employees
        if request.xhr?
          respond_to do |format|
            format.json {
              render json: {employess: @employess}
            }
          end
        end
      when 'assign'
        @seat = Seat.where(:project_id => params[:project_id], :map_id => params[:map_id], :html_id => params[:html_id]).first
        @project = Project.find(params[:project_id])
        @assignment = Assignment.new
        @assignment.project = @project
        @assignment.seat = @seat
        @assignment.assignment_date = Date.today
        @assignment.status = Assignment::ACTIVE
        if !@assignment.save
          logger.debug @assignment.errors.full_messages
        end
      end
    end
  end

  # POST /seats
  # POST /seats.json
  def create
    @seat = Seat.new(seat_params)

    respond_to do |format|
      if @seat.save
        format.html { redirect_to @seat, notice: 'Seat was successfully created.' }
        format.json { render :show, status: :created, location: @seat }
      else
        format.html { render :new }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seats/1
  # PATCH/PUT /seats/1.json
  def update
    respond_to do |format|
      if @seat.update(seat_params)
        format.html { redirect_to @seat, notice: 'Seat was successfully updated.' }
        format.json { render :show, status: :ok, location: @seat }
      else
        format.html { render :edit }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seats/1
  # DELETE /seats/1.json
  def destroy
    @seat.destroy
    respond_to do |format|
      format.html { redirect_to seats_url, notice: 'Seat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seat
      @seat = Seat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seat_params
      params.require(:seat).permit(:id, :name, :status, :assignment_date, :project)
    end
end
