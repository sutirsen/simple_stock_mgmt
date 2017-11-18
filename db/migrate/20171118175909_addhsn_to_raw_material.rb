class AddhsnToRawMaterial < ActiveRecord::Migration[5.1]
  def change
    add_column :raw_materials, :hsn, :string
    add_column :raw_materials, :gst_rate, :string
  end
end
