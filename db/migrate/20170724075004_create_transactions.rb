class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :monitory, polymorphic: true, index: true
      t.numeric :amount
      t.integer :type_of_transaction
      t.integer :payment_method

      t.timestamps
    end
  end
end
