class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.integer :follow_id
      t.integer :followed_id

      t.timestamps
    end
  end
end
