class CreateTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :taxes do |t|
      t.string :name
      t.decimal :perc
      t.boolean :is_active

      t.timestamps
    end
  end
end
