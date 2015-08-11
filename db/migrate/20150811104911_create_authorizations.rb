class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider, index: true
      t.string :uid, index: true
      t.integer :user_id, index: true
      t.string :scope

      t.timestamps null: false
    end
  end
end
