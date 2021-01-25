class DropStockWatchLists < ActiveRecord::Migration[6.0]
  def change
    drop_table :stock_watch_lists
  end
end
