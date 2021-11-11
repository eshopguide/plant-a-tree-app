# frozen_string_literal: true

class ShopSettings < ApplicationRecord
  belongs_to :shop
  encrypts :api_key

  # TODO: shop owner can choose project
  def project_id
    @project_id ||= '81818181'
  end
end
