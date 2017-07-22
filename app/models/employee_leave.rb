class EmployeeLeave < ApplicationRecord
  belongs_to :employee
  has_many :leave_transaction, dependent: :destroy
  validates :type_of_leave, presence: true
  validates :leave_amount, presence: true
  validates :financial_year, presence: true
end
