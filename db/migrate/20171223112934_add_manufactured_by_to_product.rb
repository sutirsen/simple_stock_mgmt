class AddManufacturedByToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :manufactured_by, :string
  end
end
