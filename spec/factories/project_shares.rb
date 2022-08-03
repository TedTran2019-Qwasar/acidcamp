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
FactoryBot.define do
  factory :project_share do
    
  end
end
