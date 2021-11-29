# frozen_string_literal: true

class ShopSettings < ApplicationRecord
  belongs_to :shop
  encrypts :api_key
  validates :api_key, :enterprise_id, presence: true, on: :update
end
