# frozen_string_literal: true

require 'rails_helper'

describe PlantATreeServices::PlantATree do
  let!(:shop_settings) { create(:shop_settings) }
  let(:tree_amount) { 3 }

  let(:response_body) do
    VCR.use_cassette("digital_humani/plantatree") { PlantATreeServices::PlantATree.call(shop_settings.shop, tree_amount) }
  end

  it 'successfully plant some trees' do
    expect(response_body).to have_key("uuid")
    expect(response_body["treeCount"]).to eq(3)
  end
end
