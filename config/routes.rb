Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root "home#root"
  
  resources :projects
  resources :project_shares, only: %i[create destroy]
end
