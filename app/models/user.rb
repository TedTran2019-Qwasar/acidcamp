# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Think I'll do :user, :admin, :super_admin

  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects,
           class_name: :Project,
           foreign_key: :creator_id

  has_many :project_shares,
           dependent: :destroy

  has_many :projects_shared_with,
           through: :project_shares,
           source: :project

  has_many :discussions, foreign_key: :creator_id
  has_many :tasks, foreign_key: :author_id
  has_many :messages, foreign_key: :author_id

  # def all_projects
  #   projects + projects_shared_with
  # end

  # def all_projects_sql
  #   Project
  #     .where('creator_id = ? OR id IN (?)', id, projects_shared_with.ids)
  # end

  def project_share_id(project)
    project_shares.find_by(project_id: project.id).id
  end

  # Projects still shared with + user has created
  def my_projects
    projects_shared_with.where(creator_id: id)
  end

  def projects_shared_with_me_by_others
    projects_shared_with.where.not(creator_id: id)
  end
end
