class DropWatchLists < ActiveRecord::Migration[6.0]
  def change
    drop_table :watch_lists
  end
end
