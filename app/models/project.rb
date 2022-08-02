# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  creator_id  :integer          not null
#  title       :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Project < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :creator,
  class_name: :User,
  foreign_key: :creator_id
end
