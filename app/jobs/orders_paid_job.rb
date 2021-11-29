# frozen_string_literal: true

class OrdersPaidJob
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(shop_domain, order)
    shop = Shop.find_by(shopify_domain: shop_domain)

    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    # TODO: Add error handling, if shop settings not complete
    result = PlantATreeServices::TreeCounter.call(shop, order)
    PlantATreeServices::PlantATree.call(shop, result.payload) if result.success?
  end
end
