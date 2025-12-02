class CreateStickers < ActiveRecord::Migration[7.1]
  def change
    create_table :stickers do |t|

      t.integer :road_number, null: false
      t.text :body
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
