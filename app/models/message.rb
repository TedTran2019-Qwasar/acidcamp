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

  belongs_to :author, class_name: 'User'
  belongs_to :discussion
end
