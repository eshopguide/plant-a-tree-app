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

    shop.with_shopify_session do
      # read order
      product_ids = order['order']['line_items'].map { |item| item['id'] }.join(',')

      # if condition for tree planting given
      products = ShopifyAPI::Product.find(:all, params: { ids: product_ids })
      tag_counter = products.map(&:tags).count('plant_a_tree')

      # talk to tree planting api
      if tag_counter > 0

      end
    end
  end
end
