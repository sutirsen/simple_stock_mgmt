json.extract! product, :id, :name, :description, :type, :packing, :unit, :trading_price, :mrp, :created_at, :updated_at
json.url product_url(product, format: :json)
