Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'health', to: 'health#health'

  resources :users, only: [:index, :show, :create, :update, :delete]
end
