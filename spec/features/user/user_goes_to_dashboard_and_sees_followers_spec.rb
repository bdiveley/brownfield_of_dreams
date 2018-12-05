require "rails_helper"

feature'Register user' do
  scenario 'they can see all followers on their dashboard' do
    stub_github_users_api_call

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    expect(page).to have_content('Github')

    # And under that section I should see another section titled "Followers"
    expect(page).to have_content('Followers')

    # And I should see list of all followers with their handles linking to their Github profile
    expect(page).to have_css('.login')

    within(first(".followers")) do
      expect(page).to have_link
    end
  end
end
