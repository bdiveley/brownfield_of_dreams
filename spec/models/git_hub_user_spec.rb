require "rails_helper"

describe GitHubUser do
  before(:each) do
    data = {login: "bdiveley", html_url: "/example.com" }
    @user = GitHubUser.new(data)
  end

  it "exists" do
    expect(@user).to be_a(GitHubUser)
  end

  it "has attritbutes" do
    login = "bdiveley"
    html_url = "/example.com"

    expect(@user.login).to eq(login)
    expect(@user.html_url).to eq(html_url)
  end
  it "instance methods" do
    user = create(:user, github_id: 234)
    follower = GitHubUser.new({id: 234, login: 'bdiveley', html_url: 'example.com'})
    follower_two = GitHubUser.new({id: 111, login: 'bdiveley', html_url: 'example.com'})

    expect(follower.saved_user?).to eq(true)
    expect(follower_two.saved_user?).to eq(false)
  end
end
