class Video < ApplicationRecord
  validates_presence_of :title, :position
  validates :position, on: :create, numericality: {greater_than_or_equal_to: 0}

  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.user_videos(user)
            select("videos.* , tutorials.title as tutorial_title")
            .joins(:user_videos)
            .joins(:tutorial)
            .order(:tutorial_id, :position)
            .where("user_videos.user_id = #{user.id}")
            .limit(8)
  end
end
