# frozen_string_literal: true

ShopifyApp.configure do |config|
  config.application_name = 'Plant A Tree App'
  config.old_secret = ''
  config.scope = 'read_products, read_orders' # Consult this page for more scope options:
  # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = '2021-07'
  config.shop_session_repository = 'Shop'
  config.allow_jwt_authentication = true
  config.allow_cookie_authentication = !Rails.configuration.force_iframe
  config.reauth_on_access_scope_changes = true

  config.api_key = ENV.fetch('SHOPIFY_API_KEY', '').presence
  config.secret = ENV.fetch('SHOPIFY_API_SECRET', '').presence
  if defined? Rails::Server
    raise('Missing SHOPIFY_API_KEY. See https://github.com/Shopify/shopify_app#api-keys') unless config.api_key
    raise('Missing SHOPIFY_API_SECRET. See https://github.com/Shopify/shopify_app#api-keys') unless config.secret

    config.webhooks = [
      {
        topic: 'orders/paid',
        address: "#{ENV['APP_HOME']}/custom_webhooks/orders_paid",
        fields: %w[id line_items],
        format: 'json'
      }
    ]
  end
end
