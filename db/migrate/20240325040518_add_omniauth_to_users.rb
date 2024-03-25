class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :uid, :string
    add_column :users, :provider, :string, null: false, default: ""

    add_index :users, [:uid, :provider], unique: true
  end

  def down
    remove_column :users, :uid, :string
    remove_column :users, :provider, :string
  end
end
