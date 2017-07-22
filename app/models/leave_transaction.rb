class LeaveTransaction < ApplicationRecord
  belongs_to :employee
  belongs_to :employee_leave
  validates :employee_leave_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_with DatePrecedenceValidator, fields: [:start_date, :end_date]
end
