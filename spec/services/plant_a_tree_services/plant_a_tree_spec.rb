# frozen_string_literal: true

require 'rails_helper'

describe PlantATreeServices::PlantATree do
  let!(:shop_settings) { create(:shop_settings) }

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

  let(:result) { PlantATreeServices::PlantATree.call(shop_settings.shop, tree_amount) }

  before do
    stub_request(:post, 'https://api.sandbox.digitalhumani.com/tree')
      .with(body: request_body.to_json, headers: request_header)
      .to_return(status: 200, body: response_body.to_json, headers: {})
  end

  it 'successfully plant some trees' do
    expect(result).to eq(response_body)
  end
end
