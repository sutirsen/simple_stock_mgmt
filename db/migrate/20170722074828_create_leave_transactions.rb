class CreateLeaveTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :leave_transactions do |t|
      t.references :employee, foreign_key: true
      t.references :employee_leave, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.text :description

      t.timestamps
    end
  end
end
