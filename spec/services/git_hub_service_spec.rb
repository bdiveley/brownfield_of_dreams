require 'rails_helper'

describe GitHubService do
  it "exists" do
    service = GitHubService.new({token: "token #{ENV["Github_Token"]} "})

    expect(service).to be_a(GitHubService)
  end

  context "Instance Methods" do
    context "repo_list" do
      it "should return an array of hashes" do
        VCR.use_cassette("github_repos_cassette") do
          service = GitHubService.new({token: "#{ENV["Github_Token"]} "})

          expect(service.repo_list).to be_a(Array)
          expect(service.repo_list.first).to be_a(Hash)
          expect(service.repo_list.first).to have_key(:name)
          expect(service.repo_list.first).to have_key(:html_url)
        end
      end
    end
  end
end
