# frozen_string_literal: true

class ShopSettingsController < AuthenticatedController
  before_action :find_shop_and_settings, only: %i[show edit update]
  before_action :find_projects, only: :edit

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
    params.permit(:api_key, :enterprise_id, :project_id)
  end

  def find_shop_and_settings
    @shop = Shop.find_by(shopify_domain: @current_shopify_session.domain)
    @shop_settings = @shop.shop_settings
  end

  def find_projects
    return if Rails.cache.redis.keys.include?('projects')

    PlantATreeServices::CacheProjectList.call(@shop)
  end
end
