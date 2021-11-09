# frozen_string_literal: true

module PlantATree
  class TreeCounter < ApplicationService
    def initialize(shop, order)
      @shop = shop
      @order = order
    end

    def call
      result = sum_trees

      if result.positive?
        OpenStruct.new({ success?: true, payload: result })
      else
        OpenStruct.new({ success?: false, message: 'No trees found!' })
      end
    end

    private

    # Sum quantity of an orders 'plant a tree' products
    # return integer
    def sum_trees
      tree_line_items&.sum { |item| item['quantity'] }
    end

    # Get all line items of an order that are a 'plant_a_tree' product
    # return array of hashes
    def tree_line_items
      line_items = @order['order']['line_items']
      line_items.select { |item| tree_product_ids.include?(item['product_id']) }
    end

    # Get the ids of all products in the shop tagged as 'plant_a_tree'
    # return array
    def tree_product_ids
      tree_products = @shop.with_shopify_session do
        ShopifyAPI::Product.find(:all, params: { tags: 'plant_a_tree', fields: 'id' })
      end

      tree_products.map(&:id)
    end
  end
end
