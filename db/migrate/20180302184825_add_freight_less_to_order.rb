class AddFreightLessToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :freight_less, :decimal
  end
end
