# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'splash_page#index'
  get '/home', to: 'shop_settings#show'

  mount ShopifyApp::Engine, at: '/'

  get '/shop_settings(/:id)', as: 'edit_shop_settings', to: 'shop_settings#edit'
  patch '/shop_settings(/:id)', as: 'update_shop_settings', to: 'shop_settings#update'

  post 'webhooks/orders_paid', to: 'webhooks#orders_paid'
end
