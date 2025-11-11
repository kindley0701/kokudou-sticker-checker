class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|

      t.integer :sticker_id
      t.string :name
      t.integer :prefecture
      t.integer :zipcode
      t.string :address

      t.timestamps
    end
  end
end
