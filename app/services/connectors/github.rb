module Connectors

  class Github

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
      repo_graph_id = @graph.node(GraphLabels::Github::REPOSITORY, name: repository.name)
      return repo_graph_id
    end

    def process_commits(repo_name, repo_graph_id)
      commits = client.commits(repo_name)
      commits.each do |commit|
        process_commit(commit, repo_graph_id)
      end
    end

    def process_commit(commit, repo_graph_id)
      graph_id = @graph.node GraphLabels::Github::COMMIT,
        sha: commit.sha,
        message: commit.commit.message
      # TODO: add author/person handling
      # TODO: add topic extraction
    end

    def client
      @client ||= Octokit::Client.new(:access_token => @access_token)
    end

  end

end
