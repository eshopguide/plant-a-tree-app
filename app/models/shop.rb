# frozen_string_literal: true

class Shop < ApplicationRecord
  include ShopifyApp::ShopSessionStorageWithScopes
  has_one :shop_settings

  after_create :make_shop_settings

  def api_version
    ShopifyApp.configuration.api_version
  end

  # TODO: needed for specs. Remove if another solution for login helper was found
  def sync_shopify_data; end

  private

  def make_shop_settings
    create_shop_settings
  end
end
