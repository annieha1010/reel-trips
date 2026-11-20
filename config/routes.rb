Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  #I relocate the :destroy
  resources :trips, only: [ :new, :create, :index, :show, :update, :destroy] do
    resources :messages, only: [:create]
  end

  # resource :theme, only: [ :update ]
  patch '/themes/:theme', to: 'themes#update', as: :theme
end
