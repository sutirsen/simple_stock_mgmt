Rails.application.routes.draw do
  get 'temp_bill/new'
  post 'temp_bill/create'

  resources :products
  resources :purchases
  resources :raw_materials
  resources :third_parties
  resources :employees do
    resources :employee_leaves
  end
  resources :companies
  root :to => 'sessions#home'
  resources :users
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/employees/:emp_id/leave_transaction', to: redirect { |params| "/employees/#{params[:emp_id]}/employee_leaves" }
  post '/employees/:employee_id/leave_transaction' => 'employee_leaves#addLeave', as: 'leave_transactions'

end
