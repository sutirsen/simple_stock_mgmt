class Purchase < ApplicationRecord
  belongs_to :raw_material
  belongs_to :third_party
  has_one :financial_transaction, :as => :monitory, :dependent => :destroy
  validates_presence_of :qty
  validates_numericality_of :qty
  after_save :increase_raw_material_quantity, :decrease_third_party_due
  after_destroy :decrease_raw_material_quantity, :increase_third_party_due
  # accepts_nested_attributes_for :financial_transaction
  private
    def increase_raw_material_quantity
      raw_material = self.raw_material
      self.raw_material.update_attribute(:qty, raw_material.qty + self.qty)
    end

    def decrease_raw_material_quantity
      raw_material = self.raw_material
      self.raw_material.update_attribute(:qty, raw_material.qty - self.qty)
    end


    def decrease_third_party_due
      if self.financial_transaction.payment_method == "no_payment"
        third_party = self.third_party
        self.third_party.update_attribute(:due, third_party.due - self.financial_transaction.amount)
      end
    end

    def increase_third_party_due
      if self.financial_transaction.payment_method == "no_payment"
        third_party = self.third_party
        self.third_party.update_attribute(:due, third_party.due + self.financial_transaction.amount)
      end
    end

end
