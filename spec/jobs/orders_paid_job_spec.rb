# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OrdersPaidJob do
  let(:shop_domain) { 'plantatreeapp.myshopify.com' }
  let!(:shop) { create(:shop, shopify_domain: shop_domain) }

  let(:order_params) { JSON.parse(load_order('order_paid')) }
  let(:product_ids) { order_params['order']['line_items'].map { |item| item['id'] }.join(',') }

  let(:line_items) { JSON.parse(load_products('line_items')) }

  before do
    stub_request(:get, "https://#{shop_domain}/admin/api/2021-07/products.json?ids=#{product_ids}")
      .to_return(status: 200, body: line_items.to_json, headers: {})
  end

  context 'orders/paid' do
    it 'has enqueued sidekiq job' do
      OrdersPaidJob.perform_async(shop_domain, order_params)
      expect(OrdersPaidJob).to have_enqueued_sidekiq_job(shop_domain, order_params)
    end
  end
end
