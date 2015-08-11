class User < ActiveRecord::Base
  has_many :authorizations

  validates :email, presence: true, uniqueness: true

  def self.create_from_auth_hash(auth_hash)
    user = self.new name: auth_hash["info"]["name"],
      email: auth_hash["info"]["email"]
    user.authorizations.build provider: auth_hash["provider"],
      uid: auth_hash["uid"]
    user.save!
    return user
  end
end
