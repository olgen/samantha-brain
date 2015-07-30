require 'rails_helper'

describe klass = Connectors::Github do
  let(:access_token) { ENV['GITHUB_ACCESS_TOKEN'] }
  let(:graph) { instance_double("graph") }
  let(:connector) { klass.new(access_token, graph) }
  let(:owner) { 'olgen' }
  let(:repo) { "olgen/lita-samantha" }
  let(:repo_graph_id) { "repository_#{repo}" }

  describe "#repos" do
    subject { connector.repos(owner) }
    it { should be_a(Array)}
  end

  describe "#connect_repo" do
    subject { connector.connect_repo(repo) }
    it "creates a node for the repo" do
      expect(graph).to receive(:node)
        .with("GithubRepository", {name: repo.split("/").last})
        .and_return(repo_graph_id)
      subject
    end

  end

  describe "#process_commits" do
    subject { connector.process_commits(repo, repo_graph_id) }

    it "creates a node for each commit" do
      expect(graph).to receive(:node)
        .with("GithubCommit", hash_including(:message, :sha))
        .at_least(1).times
        .and_return(1)
      subject
    end
  end

end
