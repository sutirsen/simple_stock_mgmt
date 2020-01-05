class AddPlaceOfDeliveryToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :place_of_delivery, :string, :default => ""
  end
end
