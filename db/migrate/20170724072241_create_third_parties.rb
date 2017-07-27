class CreateThirdParties < ActiveRecord::Migration[5.1]
  def change
    create_table :third_parties do |t|
      t.string :name
      t.text :address
      t.string :phn_number
      t.string :gst_number
      t.numeric :due

      t.timestamps
    end
  end
end
