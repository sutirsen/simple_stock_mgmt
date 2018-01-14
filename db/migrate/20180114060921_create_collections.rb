class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.references :third_party, foreign_key: true
      t.date :collection_date
      t.text :details
      t.string :bill_number

      t.timestamps
    end
  end
end
