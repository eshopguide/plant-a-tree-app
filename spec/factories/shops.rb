FactoryBot.define do
  factory :shop do
    shopify_domain { "#{SecureRandom.hex(8)}.myshopify.com" }
    shopify_token { "shpat_#{SecureRandom.hex(12)}" }
  end
end
