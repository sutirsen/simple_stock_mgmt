class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.references :raw_material, foreign_key: true
      t.references :third_party, foreign_key: true
      t.numeric :rate_of_unit
      t.numeric :qty
      t.string :batch_no
      t.date :expiry_date
      t.text :remarks

      t.timestamps
    end
  end
end
