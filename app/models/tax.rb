class Tax < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :perc
  validates_presence_of :is_active
end
