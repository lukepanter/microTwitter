Rails.application.routes.draw do
  resources :likes
  resources :follows
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'main' ,to: 'users#main'
  post 'login' ,to: 'users#login'
  get 'feed/:id' ,to: 'users#feed'
  get 'profile/:name' ,to: 'users#profile'
  get 'profile/:name' ,to: 'users#profile'
  get 'follow/:id' ,to: 'follows#follow'
  get 'unfollow/:id' ,to: 'follows#unfollow'
  get 'like/:id' ,to: 'likes#like'
  get 'unlike/:id' ,to: 'likes#unlike'
end
