Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'health', to: 'health#health'

  resources :users, only: [:index, :show, :create, :update, :delete]
  resources :sessions, only: [:create]
  delete 'sessions', to: 'sessions#destroy'

  scope 'forget_password' do
    post '', to: 'forget_password_tokens#create'
    get ':token', to: 'forget_password_tokens#show'
    delete '', to: 'forget_password_tokens#destroy'
  end

end
