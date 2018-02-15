# Preview all emails at http://localhost:3000/rails/mailers/mailer
class MailerPreview < ActionMailer::Preview
  def notify
    Mailer.notify(watcher.id, Time.now.iso8601, 1)
  end

  def confirmation
    Mailer.confirmation(watcher.id, watcher.email)
  end

  private

  def wallet_address
    "GAN5C5R7U6AWGZVJPT6GES6M2UDKJ2MARBAR45PVZGSETQYZY4OAQHXS"
  end

  def wallet_address_digest
    Digest::SHA1.hexdigest(wallet_address)
  end

  def watcher
    Watcher
      .create_with(wallet_address: wallet_address, email: "john@example.com")
      .find_or_create_by(wallet_address_digest: wallet_address_digest)
  end
end
