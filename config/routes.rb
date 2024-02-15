Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

# 顧客用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#ゲストログイン用

get "users" => redirect("/users/sign_up")

devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end


# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  get 'top' => 'homes#top', as: ''
  resources :genres, only: [:index, :create, :edit, :update, :destroy]
  resources :shops, only: [:index, :create, :edit, :update, :destroy]
end

scope module: :public do
  root to: "homes#top"

  get 'users/mypage/:id' => 'users#show', as: 'mypage'
  get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'

  resources :users, only: [:index, :create, :edit, :update, :destroy]

  resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end
 end
end

