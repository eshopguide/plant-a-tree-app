# frozen_string_literal: true

class ShopSettings < ApplicationRecord
  belongs_to :shop
  encrypts :api_key
end
