class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: %i[update destroy edit]

  def index
    @tasks = @project.tasks
  end

  def edit
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    @task.project_id = @project.id
    @task.author_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to request.referer, notice: 'Task was successfully created.' }
      else
        format.html { redirect_to request.referer, notice: @task.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_url(@project), notice: 'Task was successfully updated.' }
      else
        format.html { render :edit, notice: @task.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @task
    @task.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Task was successfully destroyed.' }
    end
  end

  private

  def set_project
    @project = if current_user.has_role? :super_admin
                 Project.find(params[:project_id])
               else
                 current_user.projects_shared_with.find(params[:project_id])
               end
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
