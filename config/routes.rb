Rails.application.routes.draw do
  get 'reports/index'

  resources :collections do
    get 'invoice', on: :member
  end
  resources :operational_expenses do
    get 'invoice', on: :member
  end
  resources :coupons
  resources :taxes
  get 'temp_bill/new'
  post 'temp_bill/create'

  resources :products
  resources :purchases
  resources :orders do
    get 'invoice', on: :member
  end
  resources :raw_materials
  resources :third_parties
  resources :employees do
    resources :employee_leaves
  end
  resources :companies
  root :to => 'sessions#home'
  resources :users do
    member do
      post 'reset'
    end
  end
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/employees/:emp_id/leave_transaction', to: redirect { |params| "/employees/#{params[:emp_id]}/employee_leaves" }
  post '/employees/:employee_id/leave_transaction' => 'employee_leaves#addLeave', as: 'leave_transactions'

  # Cart routes
  post '/cart/add' => 'cart#add_product_to_cart'
  post '/cart/remove' => 'cart#remove_product_from_cart'
  get '/cart/' => 'cart#index'

  # Tax routes
  post '/cart/taxes/modify' => 'cart#modify_tax_perc'

  #coupon extra routes
  post '/coupons/apply' => 'coupons#apply_coupon'
  post '/coupons/remove' => 'coupons#remove_coupon'

  #Freight less deduction
  post '/orders/apply_freight_less' => 'orders#apply_freight_less'

end
