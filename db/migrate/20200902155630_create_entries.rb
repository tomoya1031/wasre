class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|

      t.integer :user_id, null: false
      t.string :room_id, null: false
      t.timestamps
    end
  end
end
