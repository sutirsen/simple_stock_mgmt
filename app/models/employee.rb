class Employee < ApplicationRecord
  belongs_to :company
  has_many :employee_leave
  has_one :employee_salary_detail
end
