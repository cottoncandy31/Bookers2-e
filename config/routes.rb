Rails.application.routes.draw do

  devise_for :users

  root to: "homes#top"
  get '/home/about'=> 'homes#about', as: "about"
  
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:create, :index, :show, :edit, :update]
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

end
