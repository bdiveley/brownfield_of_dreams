require 'rails_helper'

describe 'User' do
  it 'can see an Add Link next to a github user on the dashboard only if the github user is in the db' do
    stub_github_followers_api_call
    stub_github_following_api_call

    user = create(:user)
    follower = create(:user, github_id: 36523304)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within(".followers") do
      expect(page).to have_link("Add Friend", count: 1)
    end

    within(".following") do
      expect(page).to have_link("Add Friend", count: 1)
    end
  end
  it 'can add a new friend by clicking on the Add Friend link' do
    stub_github_followers_api_call
    stub_github_following_api_call

    user = create(:user)
    follower = create(:user, github_id: 36523304, first_name: "French", last_name: "Bulldog")
    follower_two = create(:user, first_name: "Grizzley", last_name: "Bear")


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within(".friends") do
      expect(page).not_to have_content("French Bulldog")
    end

    within(".followers") do
      click_link "Add Friend"
    end

    expect(current_path).to eq(dashboard_path)

    within(".friends") do
      expect(page).to have_content("French Bulldog")
      expect(page).not_to have_content("Grizzley Bear")
    end
  end
  it 'cannot add a new friend if the friend is not in the database' do
    stub_github_followers_api_call
    stub_github_following_api_call

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit friendship_path(36523333)
    save_and_open_page
    expect(page).to have_content("Cannot add friends with unlinked GitHub accounts")
    expect(current_path).to eq(dashboard_path)
  end
end
