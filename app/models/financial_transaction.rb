class FinancialTransaction < ApplicationRecord
  belongs_to :monitory, :polymorphic => true
  validates :amount, presence: true
  enum type_of_transaction: [ :credit, :debit ]
  enum payment_method: [ :cash, :net_banking, :wallet, :cards, :upi, :no_payment ]
end
