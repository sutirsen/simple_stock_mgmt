class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.references :company, foreign_key: true
      t.text :address
      t.string :voter_card_no
      t.string :aadhar_card_no
      t.string :pan_no
      t.date :date_of_joining
      t.string :designation
      t.string :type_of_work
      t.text :job_desc
      t.text :terms

      t.timestamps
    end
  end
end
