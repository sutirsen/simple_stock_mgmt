json.extract! employee, :id, :name, :company_id, :address, :voter_card_no, :aadhar_card_no, :pan_no, :date_of_joining, :designation, :type_of_work, :job_desc, :terms, :created_at, :updated_at
json.url employee_url(employee, format: :json)
