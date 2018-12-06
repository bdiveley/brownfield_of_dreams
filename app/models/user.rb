class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def find_or_create_from_auth_hash(user, auth_hash)
    token = auth_hash["credentials"]["token"]
    user.update(token: token)
    user.save
  end
end
