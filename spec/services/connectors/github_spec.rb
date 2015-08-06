require 'rails_helper'

describe klass = Connectors::Github do
  let(:access_token) { ENV['GITHUB_ACCESS_TOKEN'] }
  let(:connector) { klass.new(access_token) }
  let(:owner) { 'olgen' }
  let(:repo_full_name) { "olgen/lita-samantha" }
  let(:repo_node) { connector.connect_repo(repo_full_name) }

  describe "#repos" do
    subject { connector.repos(owner) }
    it { should be_a(Array)}
  end

  describe "#connect_repo" do
    subject { repo_node }

    it "creates a node for the repo_full_name" do
      subject
      expect(repo_node.name).to eql(repo_full_name.split("/").last)
    end
  end

  describe "#process_commits" do
    subject do
      connector.process_commits(repo_full_name, repo_node)
    end

    it 'creates commits' do
      expect { subject }.to change{ Graph::Github::Commit.count }
    end

    it 'creates relationships to repo & author' do
      subject
      commit_node = Graph::Github::Commit.last
      expect(commit_node.repository).to eql(repo_node)
      expect(repo_node.commits).to include(commit_node)

      expect(commit_node.author).to be_a(Graph::Person)
      expect(commit_node.author.creations).to include(commit_node)
    end

  end

end
