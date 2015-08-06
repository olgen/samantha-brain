class Github::Branch
  include Neo4j::ActiveNode

  property :full_name, index: :exact, unique: true
  property :name

  has_one :out, :repository,
    model_class: Github::Repository,
    type: 'BELONGS_TO',
    unique: true

end
