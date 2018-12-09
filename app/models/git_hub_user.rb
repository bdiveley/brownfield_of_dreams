class GitHubUser
  attr_reader :login,
              :html_url,
              :id

  def initialize(data)
    @login = data[:login]
    @html_url = data[:html_url]
    @id = data[:id]
  end

  def saved_user?
    User.find_by(github_id: id) != nil
  end
end
