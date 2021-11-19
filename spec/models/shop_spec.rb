# frozen_string_literal: true

require 'rails_helper'

describe Shop, type: :model do
  it { is_expected.to have_one(:shop_settings) }
  it { is_expected.to callback(:make_shop_settings).after(:create) }
end
