class UserFacade

  def initialize(data)
    @token = data.token
    @_search_repo_result = nil
  end

  def repos
    search_repo_result[0..4].map do |repo_data|
      Repo.new(repo_data)
    end
  end

  private

  def search_repo_result
    @_search_repo_result ||= service.repo_list
  end
  def service
    GitHubService.new({token: @token})
  end

end
