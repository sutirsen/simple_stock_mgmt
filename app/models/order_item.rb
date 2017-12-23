class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  after_save :decrease_product_quantity
  after_destroy :increase_product_quantity

  private
    def increase_product_quantity
      product = self.product
      self.product.update_attribute(:available_units, product.available_units + self.qty)
    end
    
    def decrease_product_quantity
      product = self.product
      self.product.update_attribute(:available_units, product.available_units - self.qty)
    end
end
