Rails.application.routes.draw do
  
  #ROOT
  root 'home#index'
  
  
  #use custom controllers ( our registration controller )
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  
  resources :posts do

    #uses posts/comments_controller.rb
    resources :comments, module: :posts
    
    #resources :comments
  end

  resources :comments do
    resources :comments, module: :comments
    #resources :comments
    
  end

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
