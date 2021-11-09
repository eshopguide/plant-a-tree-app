# frozen_string_literal: true

class WebhooksController < ApplicationController
  include ShopifyApp::WebhookVerification

  # POST /webhooks/orders_paid
  def orders_paid
    OrdersPaidJob.perform_async(shop_domain, order_params.to_h)
    head :no_content
  end

  private

  def order_params
    params.except(:controller, :action, :type)
  end
end
