# frozen_string_literal: true

class DhApiSettings < ApplicationRecord
  validate :only_one_settings_object, on: :create

  encrypts :api_key

  private

  def only_one_settings_object
    errors.add(:base, 'Settings object for digital humani API already exists') if DhApiSettings.count.positive?
  end
end
