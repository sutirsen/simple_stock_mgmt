class AddHsnToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :hsn, :string
    add_column :products, :batch, :string
    add_column :products, :mfg_date, :string
    add_column :products, :use_within, :string
  end
end
