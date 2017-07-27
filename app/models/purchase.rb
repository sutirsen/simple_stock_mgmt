class Purchase < ApplicationRecord
  belongs_to :raw_material
  belongs_to :third_party
  has_one :transaction, :as => :monitory
end
