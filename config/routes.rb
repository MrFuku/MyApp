Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_scope :user do
    get     '/signup',        to: 'users/registrations#new'
    post    '/signup',        to: 'users/registrations#create'
    get     '/edit',          to: 'users/registrations#edit', as: :edit_user
    put     '/edit',          to: 'users/registrations#update', as: :user_registration
    delete  '/users/:id',     to: 'users/registrations#destroy', as: :user_delete
    get     '/login',         to: 'users/sessions#new', as: :new_user_session
    post    '/login',         to: 'users/sessions#create'
    delete  '/logout',        to: 'users/sessions#destroy'
    get     '/confirmations', to: 'users/confirmations#show', as: :user_confirmation
    get     '/password/new',  to: 'users/passwords#new'
    post    '/password',      to: 'users/passwords#create'
    get     '/password/edit', to: 'users/passwords#edit', as: :edit_password
    put     'password',       to: 'users/passwords#update'
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users, only: [:show,:index]
  root              to: 'static_pages#home';
  get  '/help',     to: 'static_pages#help'
  get  '/about',    to: 'static_pages#about'
  get  '/contact',  to: 'static_pages#contact'
  resources :microposts, only: [:create, :destroy, :show]
  resources :comments, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
