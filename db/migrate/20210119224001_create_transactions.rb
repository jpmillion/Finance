class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :name
      t.integer :shares
      t.float :value

      t.timestamps
    end
  end
end
