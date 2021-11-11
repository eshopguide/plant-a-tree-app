# frozen_string_literal: true

class Shop < ApplicationRecord
  include ShopifyApp::ShopSessionStorageWithScopes
  has_one :dh_api_settings

  def api_version
    ShopifyApp.configuration.api_version
  end
end
