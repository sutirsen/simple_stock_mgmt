class Order < ApplicationRecord
  belongs_to :third_party
  belongs_to :coupon, :optional => true
  has_many :order_items, :dependent => :destroy
  has_many :order_taxes, :dependent => :destroy
  has_one :financial_transaction, :as => :monitory, :dependent => :destroy
  has_one :transport, :dependent => :destroy
  after_create :increase_third_party_due
  after_destroy :decrease_third_party_due
  # accepts_nested_attributes_for :financial_transaction
  private
    def decrease_third_party_due
      third_party = self.third_party
      if self.financial_transaction.payment_method == "no_payment"
        self.third_party.update_attribute(:due, third_party.due - self.total_payable)
      elsif self.financial_transaction.amount != self.total_payable
        self.third_party.update_attribute(:due, third_party.due - (self.total_payable - self.financial_transaction.amount))
      end
    end

    def increase_third_party_due
      third_party = self.third_party
      if self.financial_transaction.payment_method == "no_payment"
        self.third_party.update_attribute(:due, third_party.due + self.total_payable)
      elsif self.financial_transaction.amount != self.total_payable
        self.third_party.update_attribute(:due, third_party.due + (self.total_payable - self.financial_transaction.amount))
      end
    end
end
