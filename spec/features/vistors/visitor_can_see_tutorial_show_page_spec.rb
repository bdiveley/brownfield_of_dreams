require "rails_helper"

describe 'Visitor' do
  it 'can see tutorial show page' do
    tutorial = create(:tutorial, classroom: true)
    video = create(:video, tutorial: tutorial)

    visit '/tutorials/1'

    expect(current_path).to eq(root_path)
  end
end
