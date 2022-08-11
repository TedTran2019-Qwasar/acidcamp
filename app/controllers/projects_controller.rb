class ProjectsController < ApplicationController
  before_action :authenticate_user! # Direct if not signed in
  before_action :set_project, only: %i[show edit update destroy add_attachment
                                       remove_attachment add_admin remove_admin]

  def index
    @projects = case params[:filter]
                when 'owned'
                  current_user.projects
                when 'shared'
                  current_user.projects_shared_with
                else
                  current_user.all_projects_sql
                end
    @projects = @projects.page(params[:page])
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
        format.html { render :new, notice: @project.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
      else
        format.html { render :edit, notice: @project.errors.full_messages, status: :unprocessable_entity }
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

  def add_admin
    authorize @project
    User.find(params[:member_id]).add_role(:admin, @project)
    redirect_to request.referer, notice: 'Admin permissions added'
  end

  # Kinda dumb to allow admins to add/remove admin permissions
  # But it's just a demonstration, otherwise I'd make it a super_admin exclusive permission
  def remove_admin
    authorize @project
    User.find(params[:member_id]).remove_role(:admin, @project)
    redirect_to request.referer, notice: 'Admin permissions removed'
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
