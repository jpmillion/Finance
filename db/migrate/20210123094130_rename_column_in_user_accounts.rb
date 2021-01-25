class RenameColumnInUserAccounts < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_accounts, :finacial_product_id, :financial_product_id
  end
end
