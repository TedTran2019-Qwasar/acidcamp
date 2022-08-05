class TaskPolicy < ApplicationPolicy
  # Revising Policies. Creators automatically get admin role, but it can be revoked.
  # People who belong to project OR own OR super_admin
  def index?
    true
  end

  # Same as above
  def create?
    true
  end

  # Only super_admins, admins, and creator
  def update?
    @user.has_role?(:super_admin) || 
    @user.has_role?(:admin, @record.project) ||
    @record.author == @user
  end

  # Same as above
  def destroy?
    update?
  end

  def edit?
    update?
  end
end
