# frozen_string_literal: true

module PlantATreeServices
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

    # Get all line items of an order that are a 'plant_a_tree_services' product
    # return array of hashes
    def tree_line_items
      line_items = @order['line_items']
      tree_product_ids = parsed_tree_product_ids
      line_items.select { |item| tree_product_ids.include?(item['product_id']) }
    end

    def parsed_tree_product_ids
      tree_product_gids.map{ |gid| gid.split("/").pop().to_i }
    end

    # Get the ids of all products in the shop tagged as 'plant_a_tree_services'
    # return array
    def tree_product_gids
      tree_products = @shop.with_shopify_session do
        query = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
          {
            products(first: 100, query: "tag:plant_a_tree") {
              edges { node { id } }
            }
          }
        GRAPHQL
        ShopifyAPI::GraphQL.client.query(query)
      end

      tree_products.data.products.edges.map(&:node).map(&:id)
    end
  end
end
