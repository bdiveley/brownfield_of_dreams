require 'rails_helper'

feature'Register user' do
  scenario 'they can see top 5 repos on their dashboard' do
    stub_github_api_call
    # As a logged in user
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # When I visit /dashboard
    visit '/dashboard'
    # Then I should see a section for "Github"
    expect(page).to have_content('Github')

    # And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github

    expect(page).to have_css('.name', count: 5 )

    within(first(".github_repos")) do
      expect(page).to have_link
    end
  end

  scenario '2 users with different keys' do
    stub_user_two_github_api_call

    user_1 = create(:user, token: ENV['user_two_Github_Token'])
    user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit '/dashboard'

    within(first(".name")) do
      info_user_1 = page.find('.name')
    end
  end
end
