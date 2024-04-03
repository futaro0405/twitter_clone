class AddProfileToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :text
    add_column :users, :location, :string
    add_column :users, :website, :text
  end
end
