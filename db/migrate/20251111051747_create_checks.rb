class CreateChecks < ActiveRecord::Migration[7.1]
  def change
    create_table :checks do |t|

      t.integer :user_id
      t.integer :sticker_id
      t.timestamps
    end
  end
end
