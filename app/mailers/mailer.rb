class Mailer < ApplicationMailer
  def confirmation(watcher_id, email)
    @watcher_id = watcher_id
    @token = ConfirmationToken.create(watcher_id)
    @unsubscribe_token = ConfirmationToken.create(@watcher_id)

    mail to: email, subject: "[STELLAR WATCHER] Confirm your e-mail"
  end

  def notify(watcher_id, timestamp, operations_count)
    @watcher = Watcher.find(watcher_id)
    @operations_description = t(:operations, count: operations_count)
    @explorer_url = "https://stellar.expert/explorer/#{Horizon.env}/account/#{@watcher.wallet_address}"
    @since = Time.parse(timestamp)
    @unsubscribe_token = ConfirmationToken.create(@watcher.id)

    mail to: @watcher.email, subject: "[STELLAR WATCHER] We detected #{@operations_description} on your wallet"
  end
end