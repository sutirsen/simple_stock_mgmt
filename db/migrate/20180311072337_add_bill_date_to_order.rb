class AddBillDateToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :bill_date, :date
  end
end
