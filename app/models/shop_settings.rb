# frozen_string_literal: true

class ShopSettings < ApplicationRecord
  belongs_to :shop
  encrypts :api_key
  validates :api_key, :enterprise_id, presence: true, on: :update

  before_update :assign_project_name

  private

  def assign_project_name
    self.project_name = Rails.cache.redis.hget('projects', self.project_id.to_s) if self.project_id
  end
end
