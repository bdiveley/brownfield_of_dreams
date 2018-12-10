class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.user_videos(user)
    joins(:user_videos)
    .order(:tutorial_id, :position)
    .where("user_videos.user_id = #{user.id}")
    require "pry"; binding.pry
  end
end
