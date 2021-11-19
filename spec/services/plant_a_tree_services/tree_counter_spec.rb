# frozen_string_literal: true

require 'rails_helper'

describe PlantATreeServices::TreeCounter do
  let(:shop_domain) { 'plantatreeapp.myshopify.com' }
  let!(:shop) { create(:shop, shopify_domain: shop_domain) }

  let(:order_params) { JSON.parse(load_order('order_paid_with_trees')) }
  let(:tree_product_gids) { %w[gid://shopify/Product/7003132068005 gid://shopify/Product/7211011539109] }

  let(:result) { PlantATreeServices::TreeCounter.call(shop, order_params) }

  before do
    # TODO: find a stable way to stub shopify api graphql request
    allow_any_instance_of(PlantATreeServices::TreeCounter).to receive(:tree_product_gids).and_return(tree_product_gids)
  end

  it 'returns success' do
    expect(result.success?).to be_truthy
    expect(result.payload).to eq(3)
  end

  context 'without tree product in order' do
    let(:order_params) { JSON.parse(load_order('order_paid_without_trees')) }
    let(:tree_product_gids) { [] }

    it 'returns failure' do
      expect(result.success?).to be_falsey
      expect(result.message).to eq('No trees found!')
    end
  end
end
