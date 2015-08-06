class Graph::Topic
  include Neo4j::ActiveNode

  property :name, index: :exact, unique: true

  has_many :in, :things,
    type: 'HAS_TOPIC',
    model_class: false
end
