class Graph::Github::Commit
  include Neo4j::ActiveNode

  property :sha
  property :message

end
