# frozen_string_literal: true

module PlantATree
  class PlantATree < ApplicationService
    def initialize(tree_amount)
      @tree_amount = tree_amount
    end

    def call
      digital_humani_api.plant_tree(project_id: '81818181', user: 'test@example.com', treeCount: @tree_amount)
    end

    private

    def digital_humani_api
      DigitalHumani::SDK.new do
        @api_key = ENV.fetch('DIGITAL_HUMANI_API_KEY')
        @enterprise_id = ENV.fetch('DIGITAL_HUMANI_ENTERPRISE_ID', '')
        @environment = ENV.fetch('DIGITAL_HUMANI_ENVIRONMENT', 'sandbox')
      end
    end
  end
end
