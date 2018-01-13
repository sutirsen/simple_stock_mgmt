class OperationalExpense < ApplicationRecord
  has_one :financial_transaction, :as => :monitory, :dependent => :destroy
end
