class ProjectPolicy < ApplicationPolicy
  # users can see all of their own projects + projects shared with them
  def index?
    true
  end

  # super_admins can see all projects
  # users can see their own projects + projects shared with them
  def show?
    true
  end

  # Anybody can create a project
  def create?
    true
  end

  # super_admins (global) can update all projects
  # users can update their own projects
  # users can update projects shared with them if given admin permissions (resource instance)
  def update?
    @user.has_role?(:super_admin) ||
      @user.has_role?(:admin, @record)
      # @user.id == @record.creator_id
  end

  # super_admins can destroy all projects
  # users can destroy their own projects
  # users can destroy projects shared with them if given admin permissions
  def destroy?
    update?
  end

  def add_attachment?
    update?
  end

  def remove_attachment?
    update?
  end
end
