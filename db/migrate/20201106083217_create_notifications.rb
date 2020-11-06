class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id
      t.integer :visited_id
      t.integer :product_id
      t.integer :comment_id
      t.integer :favorite_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
