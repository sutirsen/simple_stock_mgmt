json.extract! raw_material, :id, :name, :description, :qty, :unit, :created_at, :updated_at
json.url raw_material_url(raw_material, format: :json)
