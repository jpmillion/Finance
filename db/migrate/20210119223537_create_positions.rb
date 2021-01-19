class CreatePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :positions do |t|
      t.string :name
      t.integer :shares
      t.string :sector
      t.integer :user_account_id

      t.timestamps
    end
  end
end
