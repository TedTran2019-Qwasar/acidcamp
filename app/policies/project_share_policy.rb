class ProjectSharePolicy < ApplicationPolicy
  # Admins or super_admins can share
  def create?
    user.has_role?(:super_admin) ||
      user.has_role?(:admin, record.project) ||
      user.id == record.project.creator_id
  end

  # Admins or super_admins can unshare
  def destroy?
    create?
  end
end
