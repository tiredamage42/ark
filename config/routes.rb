Rails.application.routes.draw do
  
  
  resources :conversations do
    member do
      post :close
    end

    resources :messages
  end


  #ROOT
  root 'home#index'
  
  
  #use custom controllers ( our registration controller )
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' } do
    get ':user/edit-profile' => 'devise/registration#edit', :as => :edit_user_profile
  end
  resources :users, :only => [:show]
  
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  

  #maybe needed?
  #mount ActionCable.server => '/cable'
  
  
  resources :posts do
    #uses posts/comments_controller.rb
    resources :comments, module: :posts
    
  end

  resources :comments do
    resources :comments, module: :comments
    
  end

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
