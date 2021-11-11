# frozen_string_literal: true

require 'rails_helper'

describe PlantATreeServices::PlantATree do
  let(:enterpriseId) { ENV.fetch('DIGITAL_HUMANI_ENTERPRISE_ID', '') }
  let(:projectId) { '81818181' }
  let(:user) { 'test@example.com' }
  let(:tree_amount) { 3 }
  let(:request_header) { { 'X-Api-Key' => ENV.fetch('DIGITAL_HUMANI_API_KEY') } }
  let(:request_body) do
    {
      'enterpriseId': enterpriseId,
      'projectId': projectId,
      'user': user,
      'treeCount': tree_amount
    }
  end
  let(:response_body) do
    {
      'uuid' => SecureRandom.uuid,
      'created' => DateTime.parse(DateTime.now.to_s).iso8601,
      'treeCount' => tree_amount,
      'enterpriseId' => enterpriseId,
      'projectId' => projectId,
      'user' => user
    }
  end

  let(:result) { PlantATreeServices::PlantATree.call(tree_amount) }

  before do
    stub_request(:post, 'https://api.sandbox.digitalhumani.com/tree')
      .with(body: request_body.to_json, headers: request_header)
      .to_return(status: 200, body: response_body.to_json, headers: {})
  end

  it 'successfully plant some trees' do
    expect(result).to eq(response_body)
  end
end
