class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|

      t.references :user, null: false
      t.references :room, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
