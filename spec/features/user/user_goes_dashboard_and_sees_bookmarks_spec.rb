require "rails_helper"

feature"Users bookmarks" do
  scenario "Users sees bookmarks in dashboard" do
    # As a logged in user
    stub_github_followers_api_call
    stub_github_following_api_call

    user = create(:user)
    follower = create(:user, github_id: 36523304)
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    video_1 = create(:video, tutorial: tutorial_1, position: 1)
    video_2 = create(:video, tutorial: tutorial_1, position: 2)
    video_3 = create(:video, tutorial: tutorial_2, position: 1)
    video_4 = create(:video, tutorial: tutorial_2, position: 2)

    user_video_1 = create(:user_video, user: user, video: video_1)
    user_video_2 = create(:user_video, user: user, video: video_2)
    user_video_3 = create(:user_video, user: user, video: video_3)
    user_video_4 = create(:user_video, user: user, video: video_4)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # When I visit '/dashboard'
    visit dashboard_path
    # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
    expect(page).to have_content("Bookmarked Segments")
    # And they should be organized by which tutorial they are a part of
    within(first(".Bookmark")) do
      expect(page).to have_content(video_1.title)
    end

    within(third(".Bookmark")) do
      expect(page).to have_content(video_3.title)
    end
    # And the videos should be ordered by their position

    within(second(".Bookmark")) do
      expect(page).to have_content(video_2.title)
    end

  end
end
