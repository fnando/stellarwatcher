class Watcher < ApplicationRecord
  encrypt_attr :email, :wallet_address
  digest_attr :email, :wallet_address

  before_create :set_default_values
  after_validation :copy_error_messages

  validates_presence_of :email
  validates_format_of :wallet_address, with: /\AG[A-Z0-9]{55}\z/
  validates_uniqueness_of :wallet_address_digest, scope: :email_digest

  scope :to_be_enqueued, -> {
    all
      .where(email_confirmed: true)
      .where.not(cursor: nil)
      .where(["next_fetch <= NOW()"])
  }

  private def set_default_values
    self.next_fetch = Time.now
  end

  private def copy_error_messages
    if errors.details[:wallet_address_digest].any?
      errors.add(:wallet_address, "you're already receiving notifications from this wallet")
    end
  end
end
