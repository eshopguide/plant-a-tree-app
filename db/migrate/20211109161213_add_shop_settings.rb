class AddShopSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_settings do |t|
      t.text :api_key_ciphertext
      t.string :enterprise_id
      t.string :project_id
      t.timestamps
    end

    add_reference :shop_settings, :shop, foreign_key: true
  end
end
