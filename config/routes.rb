Rails.application.routes.draw do
  resources :posts
  #use custom controllers ( our registration controller )
  devise_for :users, controllers: { registrations: 'registrations' }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
