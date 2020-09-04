class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :introduction
      t.integer :status, null: false
      t.boolean :is_active, default: false, null: false
      t.timestamps
    end
  end
end
