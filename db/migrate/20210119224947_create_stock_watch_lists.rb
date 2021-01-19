class CreateStockWatchLists < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_watch_lists do |t|
      t.integer :stock_id
      t.integer :watch_list_id

      t.timestamps
    end
  end
end
