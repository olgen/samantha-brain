module Connectors

  class Github

    def initialize(access_token)
      @access_token = access_token
    end

    def repos(owner)
      repos = client.repos(owner)
      repos.map{|r| r['full_name']}
    end

    def connect_repo(repo_name)
      repository = client.repo(repo_name)
      repo_node = ::Github::Repository.find_or_create({full_name: repository.full_name},
        {
          name: repository.name,
          private: repository.private,
        })
      TopicManager.new(repo_node).assign_topics(repo_node.full_name)
      return repo_node
    end

    def process_commits(repo_name, repo_node)
      commits = client.commits(repo_name)
      commits.map do |commit|
        process_commit(commit, repo_node)
      end
    end

    def process_commit(commit, repo_node)
      commit_node = ::Github::Commit.find_or_create({sha: commit.sha}, {
        message: commit.commit.message,
      })

      commit_node.repository = repo_node
      commit_node.author = create_author(commit)
      commit_node.save!

      TopicManager.new(commit_node).assign_topics(commit_node.message, commit_node.sha)
      return commit
    end

    def create_author(commit)
      author = commit.commit.author
      Person.find_or_create({email: author.email},
        {name: author.name,  login: commit.author.login})
    end

    def client
      @client ||= Octokit::Client.new(:access_token => @access_token)
    end

  end

end
