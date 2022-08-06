class DiscussionPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    create?
  end

  def create?
    @user.has_role?(:super_admin) || @user.has_role?(:admin, @record.project)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
