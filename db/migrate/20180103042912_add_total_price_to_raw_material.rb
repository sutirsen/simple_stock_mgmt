class AddTotalPriceToRawMaterial < ActiveRecord::Migration[5.1]
  def change
    add_column :raw_materials, :total_price, :decimal
  end
end
