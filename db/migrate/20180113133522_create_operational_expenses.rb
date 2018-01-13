class CreateOperationalExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :operational_expenses do |t|
      t.string :name
      t.text :details
      t.date :paid_on

      t.timestamps
    end
  end
end
