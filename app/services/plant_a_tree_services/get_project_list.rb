# frozen_string_literal: true

module PlantATreeServices
  class GetProjectList < ApplicationService
    def initialize(shop)
      @shop = shop
    end

    def call
      result = digital_humani_api(@shop).projects
      cache_project_list(result)
      result
    end

    private

    # cache projects to redis db, because we will need them later on
    def cache_project_list(list)
      Rails.cache.redis.set('projects', list.to_json)
    end
  end
end
