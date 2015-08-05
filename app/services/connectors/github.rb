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
      Graph::Github::Repository.create!(name: repository.name,
                                        full_name: repository.full_name,
                                        private: repository.private
                                       )
    end

    def process_commits(repo_name, repo_graph_id)
      commits = client.commits(repo_name)
      commits.each do |commit|
        process_commit(commit, repo_graph_id)
      end
    end

    def process_commit(commit, repo_graph_id)
      Graph::Github::Commit.create! sha: commit.sha, message: commit.commit.message

      author = commit.commit.author
      create_person(author.email, author.name, commit.author.login)
      # TODO: add author-relation handling
      # TODO: add topic extraction
    end

    def create_person(email, name, login = nil)
      Graph::Person.create! name: name, email: email, login: login
    end

    def client
      @client ||= Octokit::Client.new(:access_token => @access_token)
    end

  end

end
