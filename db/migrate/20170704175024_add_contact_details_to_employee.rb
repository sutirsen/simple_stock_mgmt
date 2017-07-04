class AddContactDetailsToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :phone_no, :string
    add_column :employees, :email, :string
  end
end
