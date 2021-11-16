# frozen_string_literal: true

FactoryBot.define do
  factory :shop_settings do
    association :shop
    api_key { SecureRandom.hex(8) }
    enterprise_id { SecureRandom.hex(6) }
    project_id { SecureRandom.hex(4) }
  end
end
