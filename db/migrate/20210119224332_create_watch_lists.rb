class CreateWatchLists < ActiveRecord::Migration[6.0]
  def change
    create_table :watch_lists do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
