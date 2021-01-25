class AddTypeToPositions < ActiveRecord::Migration[6.0]
  def change
    add_column :positions, :type, :string
  end
end
