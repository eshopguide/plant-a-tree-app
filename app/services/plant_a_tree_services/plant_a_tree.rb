# frozen_string_literal: true

module PlantATreeServices
  class PlantATree < ApplicationService
    def initialize(shop, tree_amount)
      @shop = shop
      @tree_amount = tree_amount
    end

    def call
      digital_humani_api(@shop)
        .plant_tree(project_id: @shop.shop_settings.project_id, user: @shop.shopify_domain, treeCount: @tree_amount)
    end
  end
end
