module Connectors

  class Github
    REPOSITORY = "GithubRepository"
    COMMIT =  "GithubCommit"

    def initialize(access_token, graph)
      @access_token = access_token
      @graph = graph
    end


    def repos(owner)
      repos = client.repos(owner)
      repos.map{|r| r['full_name']}
    end

    def connect_repo(repo_name)
      repository = client.repo(repo_name)
      repo_graph_id = @graph.node(REPOSITORY, name: repository.name)
    end

    def process_commits(repo_name, repo_graph_id)
      commits = client.commits(repo_name)
      commits.each do |commit|
        graph_id = @graph.node COMMIT,
          sha: commit.sha,
          message: commit.commit.message
      end
    end

    def client
      @client ||= Octokit::Client.new(:access_token => @access_token)
    end

  end

end
