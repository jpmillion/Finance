class DropStocks < ActiveRecord::Migration[6.0]
  def change
    drop_table :stocks
  end
end
