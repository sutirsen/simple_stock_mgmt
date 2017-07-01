class Company < ApplicationRecord
  validates_presence_of :company_name, :ph_number, :email, :vat_number, :cst_number, :trade_license_number, :drug_license_number, :registration_number
end
