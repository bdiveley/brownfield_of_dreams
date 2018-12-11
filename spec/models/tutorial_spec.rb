require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it 'returns all tutorials with classroom equal to true' do

      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial, classroom: true)
      tutorial_3 = create(:tutorial)

      tutorials = Tutorial.filter_tutorials(nil)

      expect(tutorials).to eq([tutorial_1, tutorial_3])
    end
    it 'returns all tutorials with classroom equal to false' do
      user = create(:user)
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial, classroom: true)
      tutorial_3 = create(:tutorial)

      tutorials = Tutorial.filter_tutorials(user)

      expect(tutorials).to eq([tutorial_1, tutorial_2, tutorial_3])
    end
  end
end
