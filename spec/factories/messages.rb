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
FactoryBot.define do
  factory :message do
  end
end
