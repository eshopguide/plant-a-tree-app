# frozen_string_literal: true

class DhApiSettings < ApplicationRecord
  belongs_to :shop
  encrypts :api_key
end
