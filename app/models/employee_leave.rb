class EmployeeLeave < ApplicationRecord
  belongs_to :employee
  validates :type_of_leave, presence: true
  validates :leave_amount, presence: true
  validates :financial_year, presence: true
end
