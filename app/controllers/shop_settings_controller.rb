# frozen_string_literal: true

class ShopSettingsController < AuthenticatedController
  before_action :find_shop_and_settings, only: %i[show edit update]
  before_action :find_projects, only: :edit
  before_action :find_project_name, only: :update

  def edit
    render :form
  end

  def update
    if @shop_settings.update(shop_settings_params)
      turbo_redirect_to home_path, notice: 'Settings has been updated'
    else
      render :form, status: :unprocessable_entity
    end
  end

  private

  def shop_settings_params
    # merge project name into params if a project_id was submitted
    params.permit(:api_key, :enterprise_id, :project_id)&.merge(project_name: @project_name)
  end

  def find_shop_and_settings
    @shop = Shop.find_by(shopify_domain: @current_shopify_session.domain)
    @shop_settings = @shop.shop_settings
  end

  def find_projects
    # Only call digital humani api when api credentials exists
    @projects = PlantATreeServices::GetProjectList.call(@shop) if @shop_settings.api_key.present?
  end

  def find_project_name
    # get project name if a project_id was submitted
    project_id = shop_settings_params.try(:fetch, 'project_id', nil)
    return if project_id.blank?

    projects = JSON.parse(Rails.cache.redis.get('projects'))
    @project_name = projects.find { |project| project['id'] == project_id }['name']
  end
end
