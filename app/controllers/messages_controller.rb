class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_discussion
  before_action :set_message, only: %i[edit update destroy]

  def edit
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    @message.discussion_id = @discussion.id
    @message.author_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to request.referer, notice: "Message was successfully created." }
      else
        format.html { redirect_to request.referer, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @message
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to request.referer, notice: "Message was successfully updated." }
      else
        format.html { redirect_to request.referer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @message
    @message.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: "Message was successfully destroyed." }
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

  def set_discussion
    @discussion = @project.discussions.find(params[:discussion_id])
  end

  def set_message
    @message = @discussion.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
