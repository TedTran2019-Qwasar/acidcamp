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
require 'rails_helper'

RSpec.describe ProjectShare, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
