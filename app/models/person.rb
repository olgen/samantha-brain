class Person
  include Neo4j::ActiveNode

  property :email, index: :exact, unique: true
  property :name
  property :login

  # `model_class: false` -> for polymorphic creations
  has_many :out, :creations,
    type: 'CREATED',
    model_class: false

end
