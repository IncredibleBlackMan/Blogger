# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  avatar     :string
#  bio        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Validations' do
    before(:all) do
      @profile = create(:profile)
    end

    it 'Profile model should have valid attributes' do
      expect(@profile).to be_valid
    end
  end
end
