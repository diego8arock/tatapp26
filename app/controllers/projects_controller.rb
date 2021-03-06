class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :image, :zoneimage]
  before_action :authenticate_user!
  before_action :admin_required
  layout 'admin'

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # GET /projects/1/edit
  def zone
  end

  # POST /projects/1/image
  def image
    #sudo chmod 777 -R app/assets/images/projects/
    File.open("#{Rails.root}/app/assets/images/projects/floor-#{@project.tag.downcase}-im-#{params[:locale_name]}.png", 'wb') do |f|
      f.write(params[:image].read)
    end
    respond_to do |format|
      format.html { render :show }
      format.json { render(json: @project, :except => [:created_at, :updated_at] ) }
    end
  end

  # POST /projects/1/zoneimage
  def zoneimage
    #sudo chmod 777 -R app/assets/images/zones/
    File.open("#{Rails.root}/app/assets/images/zones/#{@project.tag}.png", 'wb') do |f|
      f.write(params[:image].read)
    end
    flash[:notice] = I18n.t("zones.image_saved")
    respond_to do |format|
      format.html { render :show }
      format.json { render(json: @project, :except => [:created_at, :updated_at] ) }
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :status, :tag)
    end
end
