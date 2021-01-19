class CreateFinancialProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :financial_products do |t|
      t.string :name
      t.integer :product_code
      t.text :description

      t.timestamps
    end
  end
end
