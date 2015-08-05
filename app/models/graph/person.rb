class Graph::Person
  include Neo4j::ActiveNode

  property :name, presence: true
  property :email
  property :login

end
