# frozen_string_literal: true

class OrdersPaidJob < ActiveJob::Base

  def perform(shop_domain:, order:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    shop.with_shopify_session do
      # read order

      # if condition for tree planting given
      # (for now: is there a tree product in the line_items)

      # talk to tree planting api
    end
  end
end
