# == Schema Information
#
# Table name: discussions
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  creator_id :integer          not null
#  project_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Discussion < ApplicationRecord
  validates :title, presence: true

  belongs_to :creator, class_name: 'User'
  belongs_to :project

  has_many :messages, dependent: :destroy
end
