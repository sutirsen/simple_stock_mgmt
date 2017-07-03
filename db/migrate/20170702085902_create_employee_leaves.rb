class CreateEmployeeLeaves < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_leaves do |t|
      t.references :employee, foreign_key: true
      t.integer :leave_amount
      t.string :type_of_leave
      t.integer :financial_year

      t.timestamps
    end
  end
end
