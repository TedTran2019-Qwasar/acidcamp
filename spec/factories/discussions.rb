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
FactoryBot.define do
  factory :discussion do
  end
end
