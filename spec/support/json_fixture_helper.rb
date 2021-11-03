# frozen_string_literal: true

module JSONFixtureHelper
  def load_order(order_name)
    file = File.open("spec/fixtures/json/orders/#{order_name}.json")
    json = file.read
    file.close
    json
  end
end
