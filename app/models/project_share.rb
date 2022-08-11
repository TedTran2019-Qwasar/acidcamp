# == Schema Information
#
# Table name: project_shares
#
#  id         :bigint           not null, primary key
#  project_id :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProjectShare < ApplicationRecord
  validate :cannot_be_project_owner, :already_shared

  belongs_to :project

  belongs_to :shared_to,
             class_name: :User,
             foreign_key: :user_id

  def cannot_be_project_owner
    errors.add(:user_id, "can't be the project owner") if project.creator_id == user_id
  end

  def already_shared
    errors.add(:user_id, 'is already shared with this project') if project.shared_with?(user_id)
  end
end
