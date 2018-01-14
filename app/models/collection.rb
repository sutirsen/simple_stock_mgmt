class Collection < ApplicationRecord
  belongs_to :third_party
  has_one :financial_transaction, :as => :monitory, :dependent => :destroy
  after_save :decrease_third_party_due
  after_destroy :increase_third_party_due

  private
    def decrease_third_party_due
      third_party = self.third_party
      # payment mode no_payment is not accepted here
      self.third_party.update_attribute(:due, third_party.due - self.financial_transaction.amount)
    end

    def increase_third_party_due
      third_party = self.third_party
      self.third_party.update_attribute(:due, third_party.due + self.financial_transaction.amount)
    end
end
