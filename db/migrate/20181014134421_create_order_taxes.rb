class CreateOrderTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :order_taxes do |t|
      t.references :tax, foreign_key: true
      t.decimal :tax_val
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
