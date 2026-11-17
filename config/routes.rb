Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :trips, only: [ :new, :create, :index, :show, :destroy ] do
    resources :messages, only: [ :create]
  end

end
