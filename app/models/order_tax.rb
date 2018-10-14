class OrderTax < ApplicationRecord
  belongs_to :tax
  belongs_to :order
end
