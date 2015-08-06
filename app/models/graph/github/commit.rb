class Graph::Github::Commit
  include Neo4j::ActiveNode

  property :sha
  property :message

  has_one :out, :repository,
    model_class: Graph::Github::Repository,
    type: 'BELONGS_TO',
    unique: true

  has_one :in, :author,
    model_class: Graph::Person,
    type: 'CREATED',
    unique: true

  has_many :out, :topics,
    model_class: Graph::Topic,
    type: 'HAS_TOPIC',
    unique: true

end
