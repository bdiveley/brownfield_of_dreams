require "rails_helper"

describe GitHubUser do
  before(:all) do
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
end
