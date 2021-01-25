class ChangeSectorToCurrentValueInPositions < ActiveRecord::Migration[6.0]
  def change
    remove_column :positions, :sector, :string
    add_column :positions, :value, :float
  end
end
