class ProjectsController < ApplicationController
  before_action :authenticate_user! # Direct if not signed in
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.creator_id = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @project
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
    end
  end
  
  private
    # Hmm, consider scoped roles later. 
    def set_project
      if current_user.has_role? :super_admin
        @project = Project.find(params[:id])
      else
        @project = current_user.projects.find(params[:id])
      end
    end

    def project_params
      params.require(:project).permit(:title, :description)
    end
end
