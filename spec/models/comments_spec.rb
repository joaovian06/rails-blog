require 'rails_helper'

RSpec.describe Comment, tyoe: :model do
  let(:comment) { FactoryBot.create(:comment) }

  describe 'belong to' do
    it 'belong to an article' do
      is_expected.to belong_to(:article)
    end
  end
end
