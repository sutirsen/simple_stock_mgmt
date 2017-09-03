class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :type
      t.string :packing
      t.numeric :unit
      t.numeric :trading_price
      t.numeric :mrp

      t.timestamps
    end
  end
end
