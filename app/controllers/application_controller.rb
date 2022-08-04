class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Resource simply refers to the User model
  def after_sign_in_path_for(resource)
    if resource.has_role? :super_admin
      # Send to active admin dashboard
    else
      # Page they were previously looking at -> projects page -> root
      session[:return_to] || projects_url || root_url
    end
  end

  def redirect_if_signed_in
    redirect_to projects_url if user_signed_in?
  end

  private

  def user_not_authorized
    flash[:notice] = 'Sorry, not authorized'
    redirect_to(request.referer || root_path)
  end
end
