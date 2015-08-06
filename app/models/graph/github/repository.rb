class Graph::Github::Repository
  include Neo4j::ActiveNode

  property :full_name, index: :exact, unique: true
  property :name
  property :private, type: Boolean

  has_many :in, :commits,
    model_class: Graph::Github::Commit,
    type: 'BELONGS_TO',
    unique: true

end
