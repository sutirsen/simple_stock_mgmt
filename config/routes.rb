Rails.application.routes.draw do
  get 'employee_leave/new'

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

end
