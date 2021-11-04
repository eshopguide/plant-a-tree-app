# frozen_string_literal: true

module JSONFixtureHelper
  def load_json_fixture(name)
    file = File.open("spec/fixtures/json/#{name}.json")
    json = file.read
    file.close
    json
  end

  def load_order(order_name)
    load_json_fixture("orders/#{order_name}")
  end

  def load_products(products_name)
    load_json_fixture("products/#{products_name}")
  end
end
