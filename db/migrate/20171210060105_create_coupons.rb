class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :type_of_discount
      t.decimal :amount
      t.datetime :valid_from
      t.datetime :valid_till
      t.boolean :is_active

      t.timestamps
    end
  end
end
