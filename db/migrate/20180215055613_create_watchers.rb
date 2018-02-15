class CreateWatchers < ActiveRecord::Migration[5.1]
  def change
    enable_extension "pgcrypto"

    create_table :watchers do |t|
      t.text :email_digest, null: false
      t.text :wallet_address_digest, null: false
      t.text :encrypted_email, null: false
      t.text :encrypted_wallet_address, null: false
      t.text :cursor, null: true
      t.boolean :email_confirmed, null: false, default: false
      t.datetime :next_fetch, null: false
      t.datetime :last_result_at, null: true

      t.timestamps
    end

    add_index :watchers, [:email_digest, :wallet_address_digest], unique: true
  end
end
