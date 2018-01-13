json.extract! operational_expense, :id, :name, :details, :paid_on, :created_at, :updated_at
json.url operational_expense_url(operational_expense, format: :json)
