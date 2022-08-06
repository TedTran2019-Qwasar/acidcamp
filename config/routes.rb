Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'home#root'

  resources :projects do
    post 'add_attachment', on: :member
    resources :tasks, only: %i[create destroy update index edit]
    resources :discussions, only: %i[create destroy update index show edit] do 
      resources :messages, only: %i[create destroy update edit]
    end
  end
  resources :project_shares, only: %i[create destroy]
end
