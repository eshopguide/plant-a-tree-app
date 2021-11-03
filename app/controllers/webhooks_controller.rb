# frozen_string_literal: true

class WebhooksController < ApplicationController
  include ShopifyApp::WebhookVerification

  # POST /webhooks/orders_paid
  def orders_paid
    OrdersPaidJob.perform_now(shop_domain: shop_domain, order: order_params)
    head :no_content
  end

  private

  def order_params
    params.except(:controller, :action, :type)
  end
end
