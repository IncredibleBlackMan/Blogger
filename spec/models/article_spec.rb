# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'Validations' do
    before(:all) do
      @article = create(:article)
    end

    it 'Comment model should have valid attributes' do
      expect(@article).to be_valid
    end
  end
end
