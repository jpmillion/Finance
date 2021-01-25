class AddValueAndSymbolInPositions < ActiveRecord::Migration[6.0]
  def change
    add_column :positions, :symbol, :string
  end
end
