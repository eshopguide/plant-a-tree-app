# frozen_string_literal: true

module ShopSettingsHelper
  def map_projects_for_selection
    # get digital humani project list from redis store
    projects = Rails.cache.redis.hgetall('projects')
    # map list to meet select_tag options
    projects.map { |id, name| [name, id] }
  end
end
