Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :update] do
    put '/add-follower' => 'users#add_follower', as: :add_follower
    put '/remove-follower' => 'users#remove_follower', as: :remove_follower
    put '/mention-user' => 'users#mention_user', as: :mention_user
  end

  root to: 'home#show'
end
