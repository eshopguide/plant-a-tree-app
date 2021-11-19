# frozen_string_literal: true

class ShopSettings < ApplicationRecord
  belongs_to :shop
  encrypts :api_key
  validates :api_key, :enterprise_id, presence: true, on: :update

  # TODO: shop owner can choose project
  def project_id
    @project_id ||= '81818181'
  end
end
