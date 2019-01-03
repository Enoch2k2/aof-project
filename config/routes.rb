Rails.application.routes.draw do
  resources :news_posts
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"
  match '/admin', to: 'admin/dashboard#index', via: :get
  ActiveAdmin.routes(self)
end
