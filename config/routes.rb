Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :update] do
    delete '/follow' => 'users#follow', as: :follow
    delete '/unfollow' => 'users#unfollow', as: :unfollow
    delete '/mention-user' => 'users#mention_user', as: :mention_user
  end

  root to: 'users#show'
end
