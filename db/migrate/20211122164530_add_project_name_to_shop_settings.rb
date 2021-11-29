class AddProjectNameToShopSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :shop_settings, :project_name, :string
  end
end
