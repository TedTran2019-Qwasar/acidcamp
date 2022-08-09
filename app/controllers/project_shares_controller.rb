class ProjectSharesController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(email: project_share_params[:email])
    unless user
      respond_to do |format|
        format.html { redirect_to request.referer, notice: 'User not found.' }
        # format.turbo_stream { flash.now[:notice] = 'Project was not shared' }
      end
      return
    end
    @project_share = ProjectShare.new
    @project_share.user_id = user.id
    @project_share.project_id = project_share_params[:project_id]
    authorize @project_share
    if @project_share.save
      @project_share.shared_to.add_role(:admin, @project_share.project) if admin_params[:admin] == '1'
      redirect_to request.referer, notice: 'Project was successfully shared.'
    else
      redirect_to request.referer, notice: @project_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @project_share = ProjectShare.find(params[:id])
    authorize @project_share
    @project_share.shared_to.remove_role(:user, @project_share.project)
    @project_share.destroy
    redirect_to request.referer, notice: 'Project was successfully unshared.'
  end

  def project_share_params
    params.require(:project_share).permit(:project_id, :email)
  end

  def admin_params
    params.require(:project_share).permit(:admin)
  end
end
