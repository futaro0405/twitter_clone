# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :telephone,  :string
    add_column :users, :birth_date, :datetime
    add_column :users, :name,       :string,    null: false,  default: 'no name'
    add_column :users, :provider,   :string,    null: false,  default: ''
    add_column :users, :profile,    :text,                    default: ''
    add_column :users, :location,   :string,                  default: ''
    add_column :users, :website,    :text,                    default: ''
    add_column :users, :uid,        :string,                  default: ''

    add_index :users, %i[uid provider], unique: true
  end

  def down
    remove_column :users, :name,        :string
    remove_column :users, :telephone,   :string
    remove_column :users, :birth_date,  :datetime
    remove_column :users, :profile,     :text
    remove_column :users, :location,    :string
    remove_column :users, :website,     :text
    remove_column :users, :uid,         :string
    remove_column :users, :provider,    :string
  end
end
