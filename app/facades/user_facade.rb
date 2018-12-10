class UserFacade

  def initialize(data)
    @user = data
    @_search_repo_result = nil
    @_search_follower_result = nil
    @_search_following_result = nil
  end

  def first_name
    user.first_name
  end

  def last_name
    user.last_name
  end

  def email
    user.email
  end

  def repos
    if user.token
      search_repo_result[0..4].map do |repo_data|
        Repo.new(repo_data)
      end
    end
  end

  def followers
    if user.token
      search_follower_result.map do |github_user|
        GitHubUser.new(github_user)
      end
    end
  end

  def friends
    user.friendships.map do |friendship|
      User.find_by(id: friendship.friend_id)
    end
  end

  def following
    if user.token
      search_following_result.map do |github_user|
        GitHubUser.new(github_user)
      end
    end
  end

  private
  attr_reader :user

  def search_repo_result
      @_search_repo_result ||= service.repo_list
  end

  def search_follower_result
    @_search_follower_result ||= service.follower_list
  end

  def search_following_result
    @_search_following_result ||= service.following_list
  end

  def service
    GitHubService.new({token: user.token})
  end

end
