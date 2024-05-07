class CreateRomms < ActiveRecord::Migration[7.0]
  def change
    create_table :romms do |t|

      t.timestamps
    end
  end
end
