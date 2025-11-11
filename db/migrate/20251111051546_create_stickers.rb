class CreateStickers < ActiveRecord::Migration[7.1]
  def change
    create_table :stickers do |t|

      t.integer :road_number
      t.text :body

      t.timestamps
    end
  end
end
