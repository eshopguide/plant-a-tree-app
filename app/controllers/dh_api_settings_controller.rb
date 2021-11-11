# frozen_string_literal: true

class DhApiSettingsController < AuthenticatedController
  before_action :find_shop_and_settings, only: %i[show edit update]

  def edit
    render :form
  end

  def update
    if @dh_api_settings.update(dh_api_settings_params)
      flash[:notice] = 'Settings has been updated'
      redirect_to home_path
    else
      flash.now[:alert] = 'Could not save settings.'
      render :form
    end
  end

  private

  def dh_api_settings_params
    params.permit(:api_key, :enterprise_id)
  end

  def find_shop_and_settings
    @shop = Shop.find_by_shopify_domain(@current_shopify_session.domain)
    @dh_api_settings = @shop.dh_api_settings
  end
end
