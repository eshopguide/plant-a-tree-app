class AddInitalDigitialHumaniApiSettings < ActiveRecord::Migration[6.1]
  # Create an empty digital humani API settings object
  def up
    DhApiSettings.create(shop: Shop.first, api_key: '', enterprise_id: nil, project_id: '81818181')
  end

  def down
    DhApiSettings.delete_all
  end
end
