# frozen_string_literal: true

require 'rails_helper'

describe PlantATree::TreeCounter do
  let(:shop_domain) { 'plantatreeapp.myshopify.com' }
  let!(:shop) { create(:shop, shopify_domain: shop_domain) }

  let(:order_params) { JSON.parse(load_order('order_paid_with_trees')) }
  let(:line_item_ids) { JSON.parse(load_products('line_items_with_trees')) }

  let(:result) { PlantATree::TreeCounter.call(shop, order_params) }

  before do
    stub_request(:get, "https://#{shop_domain}/admin/api/2021-07/products.json?fields=id&tags=plant_a_tree")
      .to_return(status: 200, body: line_item_ids.to_json, headers: {})
  end

  it 'returns success' do
    expect(result.success?).to be_truthy
    expect(result.payload).to eq(3)
  end

  context 'without tree product in order' do
    let(:order_params) { JSON.parse(load_order('order_paid_without_trees')) }
    let(:line_item_ids) { JSON.parse(load_products('line_items_without_trees')) }

    it 'returns failure' do
      expect(result.success?).to be_falsey
      expect(result.message).to eq('No trees found!')
    end
  end
end
