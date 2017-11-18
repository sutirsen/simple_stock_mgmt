class Tax < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :perc
end
