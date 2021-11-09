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

    result = PlantATree::TreeCounter.call(shop, order)

    # TODO: Do we want some error handling here?
    PlantATree::PlantATree.call(result.payload) if result.success?
  end
end
