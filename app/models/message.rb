# == Schema Information
#
# Table name: messages
#
#  id            :bigint           not null, primary key
#  body          :text             not null
#  author_id     :integer          not null
#  discussion_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Message < ApplicationRecord
  validates :body, presence: true
  broadcasts_to :project
  # after_create_commit -> { broadcast_append_to project }
  # after_destroy_commit -> { broadcast_remove_to project }
  # after_update_commit -> { broadcast_replace_to project }

  belongs_to :author, class_name: 'User'
  belongs_to :discussion
  
  has_one :project, 
  through: :discussion,
  source: :project
end
