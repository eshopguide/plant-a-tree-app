# frozen_string_literal: true

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  private

  def digital_humani_api(shop)
    DigitalHumani::SDK.new do
      @api_key = shop.shop_settings.api_key
      @enterprise_id = shop.shop_settings.enterprise_id
      @environment = ENV.fetch('DIGITAL_HUMANI_API_ENVIRONMENT', 'sandbox')
    end
  end
end
