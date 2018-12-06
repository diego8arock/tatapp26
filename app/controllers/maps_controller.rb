class MapsController < ApplicationController
  before_action :set_map, only: [:edit, :update, :destroy]
  before_action :set_maps, only: [:show]
  before_action :set_maps_by_first_project, only: [:show]
  before_action :authenticate_user!
  before_action :admin_required

  def new
    @map = Map.new
  end

  def edit
  end

  def show
    if params[:project_id].present?
      @maps = Map.where(project_id: params[:project_id])
    end
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {maps: @maps}
        }
      end
    end
  end

  def create
    @map = Map.new(map_params)

    respond_to do |format|
      if @map.save
        format.html { redirect_to @map, notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: @map }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(params[:id])
    end

    def set_maps
      @maps = Map.all
    end

    def set_maps_by_first_project
      @map_by_first_project = Map.where(project_id: Project.first(1))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:name, :seats, :height, :width, :seats_total, :project_id)
    end
end
