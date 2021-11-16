# frozen_string_literal: true

require 'rails_helper'

describe 'Update shop settings', type: :feature do
  let(:shop) { create(:shop) }
  let(:new_api_key) { SecureRandom.hex(8) }
  let(:new_enterprise_id) { SecureRandom.hex(4) }

  before do
    clear_login
    login(shop)
    visit edit_shop_settings_path
  end

  context 'with valid user intput' do
    it 'updates api credentials successfully' do
      within('form.shop-settings-form') do
        fill_in 'api_key', with: new_api_key
        fill_in 'enterprise_id', with: new_enterprise_id

        click_on 'Send'
      end

      expect(page).to have_content(new_api_key)
      expect(page).to have_content(new_enterprise_id)
      expect(page).to have_current_path(home_path(shop: shop.shopify_domain))
    end
  end

  context 'with invalid user input', js: true do
    it 'renders form with error message' do
      within('form.shop-settings-form') do
        fill_in 'api_key', with: ''
        fill_in 'enterprise_id', with: ''

        click_on 'Send'
      end

      expect(page).to have_content('Some errors occurred')
      expect(page).to have_current_path(edit_shop_settings_path)
    end
  end
end
