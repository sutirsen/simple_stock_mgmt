json.extract! coupon, :id, :name, :type_of_discount, :amount, :valid_from, :valid_till, :is_active, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
