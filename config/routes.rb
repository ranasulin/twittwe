Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    put '/add-follower' => 'users#add_follower', as: :add_follower
    #post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  root to: 'home#show'
end
