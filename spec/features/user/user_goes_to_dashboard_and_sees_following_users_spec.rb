require "rails_helper"

feature'Register user' do
  scenario 'they can see all followers on their dashboard' do
    stub_github_followers_api_call
    stub_github_following_api_call

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content('Github')

    # And under that section I should see another section titled "Following"
    expect(page).to have_content('Following')

    # And I should see list of users I follow with their handles linking to their Github profile
    expect(page).to have_css('.following')

    within(first(".following")) do
      expect(page).to have_link
    end
  end
end
