class SeatsController < ApplicationController
  before_action :set_seat, only: [:show, :edit, :update, :destroy]

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
        @vacio = Seat.where(id_project: params[:project_id], id_map: params[:map_id], code: params[:code]).empty?
        if @vacio
          @seat = Seat.where(id_project: params[:project_id], id_map: params[:map_id], id_html: params[:html_id]).first
        else
          @seat = "El asiento ya existe en otra posición con el mismo nombre."
        end
      when 'insert'
        # Insertar nuevo asiento
        @seat = Seat.new(id_project: params[:project_id], id_map: params[:map_id], id_html: params[:html_id], code: params[:code])
        @seat.save
      when 'update'
        # Actualizar el asiento
        @seat = Seat.find(params[:id])
        @seat.update(id_project: params[:project_id], id_map: params[:map_id], id_html: params[:html_id], code: params[:code])
      when 'map'
        @seat = Seat.where(id_project: params[:project_id], id_map: params[:map_id])
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
