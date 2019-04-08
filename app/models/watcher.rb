class Watcher < ApplicationRecord
  encrypt_attr :email, :wallet_address, :webhook_url
  digest_attr :email, :wallet_address

  before_create :set_default_values
  after_validation :copy_error_messages

  validates_email_format_of :email, tld: true
  validates_url_format_of :webhook_url, tld: true, allow_nil: true
  validates_format_of :wallet_address, with: /\AG[A-Z0-9]{55}\z/
  validates_uniqueness_of :wallet_address_digest, scope: :email_digest

  scope :to_be_enqueued, -> {
    all
      .where(email_confirmed: true)
      .where(["next_fetch <= NOW()"])
  }

  scope :to_be_purged, -> {
    all
      .where(email_confirmed: false)
      .where(["created_at < ?", 1.month.ago])
  }

  scope :without_cursor, -> {
    all
      .where(cursor: nil)
  }

  webhook_url_method = instance_method(:webhook_url=)
  define_method :webhook_url= do |url|
    url = nil if url.blank?
    webhook_url_method.bind(self).call(url)
  end

  private def set_default_values
    self.next_fetch = Time.now
  end

  private def copy_error_messages
    if errors.details[:wallet_address_digest].any?
      errors.add(:wallet_address, "you're already receiving notifications from this wallet")
    end
  end
end
