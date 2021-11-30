# frozen_string_literal: true

module PlantATreeServices
  class CacheProjectList < ApplicationService
    def initialize(shop)
      @shop = shop
    end

    def call
      store_projects_to_cache
    end

    private

    # call digital humani projects api
    def get_projects_from_api
      digital_humani_api(@shop).projects
    end

    # store projects to redis cache
    def store_projects_to_cache
      project_hash = get_projects_from_api.map { |p| { p['id'] => p['name'] } }.inject(:merge)
      Rails.cache.redis.hset('projects', project_hash)
    end
  end
end
