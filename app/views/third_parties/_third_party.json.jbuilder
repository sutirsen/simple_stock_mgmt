json.extract! third_party, :id, :name, :address, :phn_number, :gst_number, :due, :created_at, :updated_at
json.url third_party_url(third_party, format: :json)
