class AddTokenExpiresAtToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :token_expires_at, :datetime
  end
end
