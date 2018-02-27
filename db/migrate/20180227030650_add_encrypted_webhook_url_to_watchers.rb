class AddEncryptedWebhookUrlToWatchers < ActiveRecord::Migration[5.1]
  def change
    add_column :watchers, :encrypted_webhook_url, :text, null: true
  end
end
