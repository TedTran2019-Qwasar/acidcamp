# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  author_id   :integer          not null
#  project_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :task do
    
  end
end
