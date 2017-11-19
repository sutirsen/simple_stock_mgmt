class AddAvailableUnitsToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :available_units, :numeric
  end
end
