class ProjectsController < ApplicationController
  before_action :authenticate_user! # Direct if not signed in
  before_action :set_project, only: %i[show edit update destroy add_attachment remove_attachment]

  def index
    case params[:filter]
    when 'owned'
      @projects = current_user.projects
    when 'shared'
      @projects = current_user.projects_shared_with
    else
      @projects = current_user.all_projects_sql
    end
  end

  def show
    @tasks = @project.tasks
    @discussions = @project.discussions.includes(messages: [:author])
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
        current_user.add_role(:admin, @project)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @project
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  def add_attachment
    authorize @project
    @project.images.attach(project_params[:image])
    redirect_to request.referer, notice: 'File was successfully added.'
  end

  def remove_attachment
    authorize @project
    @project.images.find(params[:attachment_id]).purge
    redirect_to request.referer, notice: 'File was successfully deleted'
  end

  private

  def set_project
    @project = if current_user.has_role? :super_admin
                 Project.find(params[:id])
               else
                 current_user.all_projects_sql.find(params[:id])
               end
  end

  def project_params
    params.require(:project).permit(:title, :description, :image)
  end
end
