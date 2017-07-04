class AddSalaryDetailsToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :salary, :numeric
    add_column :employees, :bank_name, :string
    add_column :employees, :bank_acc_no, :string
    add_column :employees, :ifsc_code, :string
  end
end
