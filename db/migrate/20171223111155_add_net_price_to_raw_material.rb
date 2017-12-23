class AddNetPriceToRawMaterial < ActiveRecord::Migration[5.1]
  def change
    add_column :raw_materials, :net_price, :decimal
    add_column :raw_materials, :purchased_on, :date
    add_column :raw_materials, :vendor_name, :string
  end
end
