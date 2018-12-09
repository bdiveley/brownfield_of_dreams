require 'rails_helper'

describe 'User' do
  it 'can add friends if they are in the database' do
    stub_github_users_api_call

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
end
