require 'rails_helper'

feature"User invites" do
  scenario "user can invite others to the app " do
    # As a registered user
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # When I visit /dashboard
    visit dashboard_path
    # And I click "Send an Invite"
    click_button("Send an Invite")
    # Then I should be on /invite
    expect(current_path).to eq(invite_path)
    # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
    fill_in 'handle', with: "bdiveley"
    # And I click on "Send Invite"
    click_on("Send Invite")
    # Then I should be on /dashboard
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Successfully sent invite!")

    end
end
