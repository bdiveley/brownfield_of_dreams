require 'rails_helper'

describe Repo do

  before(:all) do
    data = {name: "Brownfield_of_sorrow", html_url: "/example.com" }
    @repo = Repo.new(data)

  end

  it 'exist' do
    expect(@repo).to be_a(Repo)
  end

  it 'have attributes' do
    name = "Brownfield_of_sorrow"
    url = "/example.com"

    expect(@repo.name).to eq(name)
    expect(@repo.html_url).to eq(url)
  end
end
