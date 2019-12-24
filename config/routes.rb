Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new #[知見]7-1-1 URLをアクションに紐づける
    post :import, on: :collection #[知見]
  end
end
