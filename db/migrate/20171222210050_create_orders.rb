class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :third_party, foreign_key: true
      t.decimal :total_cost
      t.decimal :total_tax
      t.decimal :discounted_amount
      t.decimal :total_payable
      t.references :coupon, foreign_key: true
      t.string :bill_no
      t.string :tr_no
      t.boolean :with_tax
      t.text :remarks

      t.timestamps
    end
  end
end
