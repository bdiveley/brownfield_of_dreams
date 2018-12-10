require 'rails_helper'

feature'User' do
  scenario 'goes to dashboard and sees a button to connect with github' do
    stub_omniauth
    stub_github_api_call
    stub_github_followers_api_call
    stub_github_following_api_call

    # As a user
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # When I visit /dashboard
    visit dashboard_path
    # Then I should see a link that is styled like a button that says "Connect to Github"
    expect(page).to have_button('Connect to Github')
    # And when I click on "Connect to Github"
    click_on 'Connect to Github'
    # Then I should go through the OAuth process

    # And I should see all of the content from the previous Github stories (repos, followers, and following)
    expect(page).to have_css('.login')

    within(first(".followers")) do
      expect(page).to have_link
    end
    expect(page).to have_css('.following')

    within(first(".following")) do
      expect(page).to have_link
    end

    expect(page).to have_css('.name', count: 5 )

    within(first(".github_repos")) do
      expect(page).to have_link
    end

    OmniAuth.config.mock_auth[:github] = nil
  end
end
