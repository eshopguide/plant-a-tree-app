# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'splash_page#index'
  get '/home', to: 'dh_api_settings#show'

  mount ShopifyApp::Engine, at: '/'

  get 'settings(/:id)', as: 'edit_dh_api_settings', to: 'dh_api_settings#edit'
  patch 'settings(/:id)', as: 'update_dh_api_settings', to: 'dh_api_settings#update'

  post 'webhooks/orders_paid', to: 'webhooks#orders_paid'
end
