class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_discussion, only: %i[edit update destroy]

  def index
    @discussions = @project.tasks
  end

  def edit
    authorize @discussion
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.project_id = @project.id
    @discussion.creator_id = current_user.id
    authorize @discussion

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to request.referer, notice: 'Discussion was successfully created.' }
      else
        format.html do
 redirect_to request.referer, notice: @discussion.errors.full_messages, status: :unprocessable_entity end
      end
    end
  end

  def update
    authorize @discussion
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to request.referer, notice: 'Discussion was successfully updated.' }
      else
        format.html { render :edit, notice: @discussion.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @discussion
    @discussion.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'Discussion was successfully destroyed.' }
    end
  end

  private

  def set_project
    @project = if current_user.has_role? :super_admin
                 Project.find(params[:project_id])
               else
                 current_user.all_projects_sql.find(params[:project_id])
               end
  end

  def set_discussion
    @discussion = @project.discussions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def discussion_params
    params.require(:discussion).permit(:title)
  end
end
