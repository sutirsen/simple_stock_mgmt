json.extract! company, :id, :company_name, :branch_name, :ph_number, :email, :web_site, :vat_number, :cst_number, :trade_license_number, :drug_license_number, :registration_number, :authorized_sign_img, :company_logo_img, :created_at, :updated_at
json.url company_url(company, format: :json)
