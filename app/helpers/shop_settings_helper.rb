# frozen_string_literal: true

module ShopSettingsHelper
  def map_projects_for_selection
    # get digital humani project list from redis store
    projects = JSON.parse(Rails.cache.redis.get('projects'))
    # map list to meet select_tag options
    projects.map{|p| [p['name'], p['id']]}
  end
end