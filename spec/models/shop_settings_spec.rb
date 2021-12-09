# frozen_string_literal: true

require 'rails_helper'

describe ShopSettings, type: :model do
  it { is_expected.to belong_to(:shop) }

  it { should validate_presence_of(:api_key).on(:update) }
  it { should validate_presence_of(:enterprise_id).on(:update) }

  it { is_expected.to callback(:assign_project_name).before(:update) }
end
