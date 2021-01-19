class CreateUserAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_accounts do |t|
      t.integer :user_id
      t.integer :finacial_product_id
      t.float :balance

      t.timestamps
    end
  end
end
