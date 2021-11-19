# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersPaidJob do
  let!(:shop_settings) { create(:shop_settings) }
  let(:shopify_domain) { shop_settings.shop.shopify_domain }

  let(:order_params) { JSON.parse(load_order('order_paid_with_trees')) }
  let(:line_item_ids) { JSON.parse(load_products('line_items_with_trees')) }

  let(:user) { 'test@example.com' }
  let(:tree_amount) { 3 }
  let(:request_header) { { 'X-Api-Key' => shop_settings.api_key } }
  let(:request_body) do
    {
      'enterpriseId': shop_settings.enterprise_id,
      'projectId': shop_settings.project_id,
      'user': user,
      'treeCount': tree_amount
    }
  end
  let(:response_body) do
    {
      'uuid' => SecureRandom.uuid,
      'created' => DateTime.parse(DateTime.now.to_s).iso8601,
      'treeCount' => tree_amount,
      'enterpriseId' => shop_settings.enterprise_id,
      'projectId' => shop_settings.project_id,
      'user' => user
    }
  end

  before do
    stub_request(:get, "https://#{shopify_domain}/admin/api/2021-07/products.json?fields=id&tags=plant_a_tree")
      .to_return(status: 200, body: line_item_ids.to_json, headers: {})

    stub_request(:post, 'https://api.sandbox.digitalhumani.com/tree')
      .with(body: request_body.to_json, headers: request_header)
      .to_return(status: 200, body: response_body.to_json, headers: {})
  end

  # TODO: refactor or delete. We don't need to test sidekiq here
  it 'has enqueued sidekiq job' do
    OrdersPaidJob.perform_async(shopify_domain, order_params)
    expect(OrdersPaidJob).to have_enqueued_sidekiq_job(shopify_domain, order_params)
  end
end
