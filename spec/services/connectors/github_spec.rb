require 'rails_helper'

describe klass = Connectors::Github do
  let(:access_token) { ENV['GITHUB_ACCESS_TOKEN'] }
  let(:graph) { instance_double("graph") }
  let(:connector) { klass.new(access_token, graph) }
  let(:owner) { 'olgen' }
  let(:repo) { "olgen/lita-samantha" }

  describe "#repos" do
    subject { connector.repos(owner) }
    it { should be_a(Array)}
  end

  describe "#connect_repo" do
    subject { connector.connect_repo(repo) }
    it "creates a node for the repo" do
      expect(graph).to receive(:node)
        .with("GithubRepository", {name: repo.split("/").last})
      subject
    end
  end

end
