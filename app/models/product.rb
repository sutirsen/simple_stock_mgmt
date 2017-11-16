class Product < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :unit
  validates_presence_of :trading_price
  validates_presence_of :mrp
end
