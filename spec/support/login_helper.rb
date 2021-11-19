# frozen_string_literal: true

# shopify login helper methods are heavily inspired by KIRILL PLATONOV
# see https://kirillplatonov.com/posts/testing-shopify-apps-in-rails/
def login(shop)
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:shopify,
                           provider: 'shopify',
                           uid: shop.shopify_domain,
                           credentials: { token: shop.shopify_token })

  Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:shopify]
  Rails.application.env_config['omniauth.params'] = { shop: shop.shopify_domain }
  Rails.application.env_config['jwt.shopify_domain'] = shop.shopify_domain

  allow_any_instance_of(Shop).to receive(:sync_shopify_data).and_return(true)

  session = ActionDispatch::Integration::Session.new(Rails.application)
  session.post('/auth/shopify')
end

def clear_login
  Rails.application.env_config.delete('omniauth.auth')
  Rails.application.env_config.delete('omniauth.params')
  Rails.application.env_config.delete('jwt.shopify_domain')
end
