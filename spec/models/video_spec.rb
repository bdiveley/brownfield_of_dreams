require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
  end

  describe 'Relationships' do
    it {should have_many(:user_videos)}
    it {should have_many(:users).through(:user_videos)}
    it {should belong_to(:tutorial)}
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:position)}
    it { is_expected.to validate_numericality_of(:position).is_greater_than_or_equal_to(0) }
  end

  describe "Class Methods" do
    it "return bookmark videos by user" do
      user = create(:user)
      follower = create(:user, github_id: 36523304)
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      video_4 = create(:video, tutorial: tutorial_2, position: 2)
      video_2 = create(:video, tutorial: tutorial_1, position: 2)
      video_3 = create(:video, tutorial: tutorial_2, position: 1)
      video_1 = create(:video, tutorial: tutorial_1, position: 1)

      user_video_1 = create(:user_video, user: user, video: video_1)
      user_video_2 = create(:user_video, user: user, video: video_2)
      user_video_3 = create(:user_video, user: user, video: video_3)
      user_video_4 = create(:user_video, user: user, video: video_4)

      expected =[video_1, video_2, video_3, video_4]
      expect(Video.user_videos(user)).to eq(expected)
    end
  end

  describe "Specials Cases" do
    it 'should run a task if any value for position is save in the database' do
      create_list(:video, 5)
      video = create(:video, position: nil)

      expect(Video.all.id).to eq(6)
    end
  end

end
