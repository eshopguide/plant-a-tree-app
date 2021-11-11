# frozen_string_literal: true

require 'rails_helper'

describe ShopSettings, type: :model do
  it { is_expected.to belong_to(:shop) }
end
