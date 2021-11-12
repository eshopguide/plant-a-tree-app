# frozen_string_literal: true

require 'rails_helper'

describe 'Show shop settings', type: :feature do
  let(:shop) { create(:shop) }

  before do
    clear_login
    login(shop)
  end

  context 'with api credentials not set yet' do
    it 'shows welcome page' do
      visit home_path

      expect(page).to have_content('Connect your shop to the Digital Humani API')
    end
  end

  context 'with api credentials set' do
    before do
      shop.shop_settings.update({ api_key: SecureRandom.hex(8), enterprise_id: SecureRandom.hex(4) })
    end

    it 'shows welcome page with api credentials' do
      visit home_path

      expect(page).to have_content(shop.shop_settings.api_key)
      expect(page).to have_content(shop.shop_settings.enterprise_id)
    end
  end
end
