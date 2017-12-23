class ThirdParty < ApplicationRecord
  enum type_of_party: [ :vendor, :customer ]
end
