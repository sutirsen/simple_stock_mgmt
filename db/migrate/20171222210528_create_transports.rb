class CreateTransports < ActiveRecord::Migration[5.1]
  def change
    create_table :transports do |t|
      t.references :order, foreign_key: true
      t.string :name
      t.string :documents_through
      t.string :no_of_cases
      t.string :contact_no

      t.timestamps
    end
  end
end
