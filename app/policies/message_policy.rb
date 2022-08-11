class MessagePolicy < ApplicationPolicy
  def edit?
    update?
  end

  # Anybody can create a message if they have access to the project
  def create?
    true
  end

  # Only super_admins, admins, and creator
  def update?
    @user.has_role?(:super_admin) ||
      @user.has_role?(:admin, @record.project) ||
      @record.author == @user
  end

  def destroy?
    update?
  end
end
