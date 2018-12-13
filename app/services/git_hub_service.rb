class GitHubService

  def initialize(filter)
    @filter = filter
  end

  def repo_list
    get_json("/user/repos")
  end

  def follower_list
    get_json("/user/followers")
  end

  def following_list
    get_json("/user/following")
  end

  def find_email
    user_info = get_json("/users/#{@filter[:handle]}")
  end

  private

  def get_json(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => "https://api.github.com") do |faraday|
      faraday.headers['authorization'] = "token #{@filter[:token]}"
      faraday.adapter Faraday.default_adapter
    end
  end

end
