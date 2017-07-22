class Employee < ApplicationRecord
  belongs_to :company
  has_many :employee_leave, dependent: :destroy
  has_many :leave_transaction, dependent: :destroy
  validates_presence_of :name, :company_id, :aadhar_card_no, :date_of_joining, :salary
end
