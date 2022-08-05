class TasksController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_project
  before_action :set_task, only: %i[update destroy edit]

  def index
    @tasks = @project.tasks
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.project_id = @project.id
    @task.author_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to request.referer, notice: "Task was successfully created." }
      else
        redirect to request.referer
      end
    end
  end

  def update
    authorize @task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to request.referer, notice: "Task was successfully updated." }
      else
        format.html { redirect to request.referer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: "Task was successfully destroyed." }
    end
  end

  private

    def set_project
      if current_user.has_role? :super_admin
        @project = Project.find(params[:project_id])
      else
        @project = current_user.all_projects_sql.find(params[:project_id])
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:description)
    end
end
