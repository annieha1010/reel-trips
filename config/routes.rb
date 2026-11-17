Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  #I relocate the :destroy
  resources :trips, only: [ :new, :create, :index, :show ] do
    resources :messages, only: [ :create]
  end
  resources :trips, only: [:destroy]

end
