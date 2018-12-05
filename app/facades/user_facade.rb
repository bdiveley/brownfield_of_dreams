class UserFacade

  def initialize(data)
    @user = data
    @_search_repo_result = nil
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
    search_repo_result[0..4].map do |repo_data|
      Repo.new(repo_data)
    end
  end

  private
  attr_reader :user

  def search_repo_result
    @_search_repo_result ||= service.repo_list
  end

  def service
    GitHubService.new({token: user.token})
  end

end
