# frozen_string_literal: true

require 'rails_helper'

describe 'Update shop settings', type: :feature do
  let(:shop) { create(:shop) }
  let(:new_api_key) { SecureRandom.hex(8) }
  let(:new_enterprise_id) { SecureRandom.hex(4) }

  before do
    clear_login
    login(shop)
    allow(Rails).to receive_message_chain(:cache, :redis, :keys, :include?).and_return(true)
    visit edit_shop_settings_path
  end

  context 'with api credentials not set yet' do
    it 'does not render the project select field' do
      expect(page).to_not have_content('Project')
      expect(page).to_not have_css('#project_id')
    end

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

  context 'with api credentials set' do
    let(:new_project_name) { 'India TIST' }
    let(:cache_projects) { JSON.parse(load_projects_list.to_json) }
    let(:mapped_project_list) { [['India TIST', '81818182']] }

    before do
      shop.shop_settings.update_columns({ api_key: new_api_key, enterprise_id: new_enterprise_id })
      allow(Rails).to receive_message_chain(:cache, :redis, :hget)
      allow_any_instance_of(ShopSettingsHelper).to receive(:map_projects_for_selection).and_return(mapped_project_list)

      visit current_path
    end

    it 'renders the project select field' do
      expect(page).to have_content('Project')
      expect(page).to have_css('#project_id')
    end

    it 'updates project successfully', js: true do
      within('form.shop-settings-form') do
        select(new_project_name, from: 'project_id')

        click_on 'Send'
      end

      expect(page).to have_content(new_project_name)
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
