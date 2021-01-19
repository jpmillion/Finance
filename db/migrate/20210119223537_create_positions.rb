class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.string :name
      t.integer :shares
      t.string :sector

      t.timestamps
    end
  end
end
