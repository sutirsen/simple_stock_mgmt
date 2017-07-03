class CreateEmployeeSalaryDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_salary_details do |t|
      t.references :employee, foreign_key: true
      t.numeric :salary_amount
      t.string :bank_acc_no
      t.string :bank_name
      t.string :ifsc_code

      t.timestamps
    end
  end
end
