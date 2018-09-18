class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string :access_token,      null: false, name: "index_api_keys_on_access_token", unique: true
      t.integer :user_id,          null: false, name: "index_api_keys_on_user_id", unique: false
      t.boolean :active,           null: false, default: true
      t.datetime :expires_at

      t.timestamps
    end

  end
end