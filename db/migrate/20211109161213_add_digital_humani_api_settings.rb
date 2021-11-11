class AddDigitalHumaniApiSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :dh_api_settings do |t|
      t.text :api_key_ciphertext
      t.string :enterprise_id
      t.string :project_id
    end

    add_reference :dh_api_settings, :shop, foreign_key: true
  end
end
