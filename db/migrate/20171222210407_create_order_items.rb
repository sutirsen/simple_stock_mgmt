class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :qty
      t.decimal :selling_price
      t.decimal :total_item_cost

      t.timestamps
    end
  end
end
