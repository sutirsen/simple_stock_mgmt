class Purchase < ApplicationRecord
  belongs_to :raw_material
  belongs_to :third_party
  has_one :financial_transaction, :as => :monitory
  accepts_nested_attributes_for :financial_transaction
end
