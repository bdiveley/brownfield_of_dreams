require 'rails_helper'

feature"User invites" do
  before(:each) do
    stub_github_api_call
    stub_github_followers_api_call
    stub_github_following_api_call

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "user can invite others to the app " do
    stub_github_invite_api_call

    visit dashboard_path

    click_button("Send an Invite")

    expect(current_path).to eq(invite_path)

    fill_in 'handle', with: "bdiveley"

    click_on("Send Invite")

    mail = ActionMailer::Base.deliveries

    expect(mail.count).to eq(1)

    expect(mail.first.body.encoded).to match("Here")

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Successfully sent invite!")
  end

  scenario "user type nonexistent handle " do
    stub_github_invite_not_found_api_call

    visit dashboard_path

    click_button("Send an Invite")

    expect(current_path).to eq(invite_path)

    fill_in 'handle', with: "El_Vago_de_al_lado"

    click_on("Send Invite")

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
