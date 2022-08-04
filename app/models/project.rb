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

  resourcify

  belongs_to :creator,
             class_name: :User

  has_many :project_shares,
           dependent: :destroy

  has_many :members,
           through: :project_shares,
           source: :shared_to
  
  has_many :discussions,
  dependent: :destroy

  has_many :tasks, 
  dependent: :destroy


  def all_members
    members + creator_sql
  end

  def creator_sql
    User
      .where(id: creator_id)
  end

  def all_members_sql
    User
      .joins('LEFT JOIN project_shares ON users.id = project_shares.user_id')
      .where('users.id = ? OR project_shares.project_id = ?', creator_id, id)
  end
end
