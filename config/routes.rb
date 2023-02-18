# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/welcome'
  devise_for :users
  
  devise_scope :user do
    authenticated :user do
      root 'categories#index', as: :authenticated_root
    end

    unauthenticated do
      root 'home#welcome', as: :unauthenticated_root
    end
  end

  resources :categories, only: [:index, :show, :new, :destroy, :create,]
  resources :expenses, only: [:index, :show, :new, :destroy, :create,]
end
