module Connectors

  class Github
    REPOSITORY = "GithubRepository"

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
      @graph.node(REPOSITORY, name: repository[:name])
      # process commits
    end

    def client
      @client ||= Octokit::Client.new(:access_token => @access_token)
    end

  end

end
