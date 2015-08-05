class Graph::Github::Repository
  include Neo4j::ActiveNode

  property :name
  property :full_name
  property :private, type: Boolean

end
