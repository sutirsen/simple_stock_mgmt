class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :branch_name
      t.numeric :ph_number
      t.string :email
      t.string :web_site
      t.string :vat_number
      t.string :cst_number
      t.string :trade_license_number
      t.string :drug_license_number
      t.string :registration_number
      t.string :authorized_sign_img
      t.string :company_logo_img

      t.timestamps
    end
  end
end
