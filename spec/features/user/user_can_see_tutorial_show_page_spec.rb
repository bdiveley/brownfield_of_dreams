require "rails_helper"

describe 'User' do
  it 'can see tutorial show page' do
    user = create(:user)
    tutorial = create(:tutorial, id: 1)
    video = create(:video, tutorial: tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/tutorials/1'

    expect(page).to have_content(video.title)

  end
  it 'does not get an error if the tutorial has no associated videos' do
    user = create(:user)
    tutorial = create(:tutorial, id: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/tutorials/1'

    expect(page).to have_content(tutorial.title)
    expect(current_path).to eq(tutorial_path(tutorial))

  end
end
