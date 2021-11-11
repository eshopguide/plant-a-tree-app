# frozen_string_literal: true

class Shop < ApplicationRecord
  include ShopifyApp::ShopSessionStorageWithScopes
  has_one :shop_settings

  after_create :make_shop_settings

  def api_version
    ShopifyApp.configuration.api_version
  end

  private

  def make_shop_settings
    create_shop_settings
  end
end
