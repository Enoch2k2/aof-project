Rails.application.routes.draw do
  resources :news_posts
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"
  match '/admin', to: 'admin/dashboard#index', via: :get
  get '/members', to: 'welcome#members', as: 'members'
  
  resources :users, only: [:show, :edit, :update]
  get '/forum', to: 'forums#index', as: 'forum'
  get '/forum/topics/:id', to: 'topics#show', as: 'forum_topic'
  get '/forum/topics/:topic_id/posts/new', to: 'posts#new', as: 'new_topic_post'
  post '/forum/topics/:topic_id/posts', to: 'posts#create', as: 'topic_posts'
  get '/forum/topics/:topic_id/posts/:id', to: 'posts#show', as: 'topic_post'
  get '/forum/topics/:topic_id/posts/:id/edit', to: 'posts#edit', as: 'edit_topic_post'
  get '/forum/topics/:topic_id/posts/:post_id/comments/:id/edit', to: 'comments#edit', as: 'edit_topic_post_comment'
  patch '/forum/topics/:topic_id/posts/:post_id/comments/:id', to: 'comments#update', as: 'topic_post_comment'
  post '/forum/topics/:topic_id/posts/:post_id/comments', to: 'comments#create', as: 'post_comments'
  patch '/forum/topics/:topic_id/posts/:id', to: 'posts#update'
  delete '/forum/topics/:topic_id/posts/:post_id/comments/:id', to: 'comments#destroy', as: 'delete_topic_post_comment'
  delete '/forum/topics/:topic_id/posts/:id', to: 'posts#destroy', as: 'delete_topic_post'
  ActiveAdmin.routes(self)
end
