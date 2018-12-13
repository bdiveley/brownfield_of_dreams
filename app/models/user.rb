require 'securerandom'

class User < ApplicationRecord
  before_create :random_generator
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name, :last_name
  enum role: [:default, :admin]
  has_secure_password

  def find_or_create_from_auth_hash(user, auth_hash)
    token = auth_hash["credentials"]["token"]
    github_id = auth_hash["extra"]["raw_info"]["id"]
    user.update(token: token)
    user.update(github_id: github_id)
    user.save
  end

private
  def random_generator
    self.activation_digest = SecureRandom.uuid
  end
end
