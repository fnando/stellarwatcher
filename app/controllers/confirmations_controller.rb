class ConfirmationsController < ApplicationController
  def pending
    @watcher = Watcher.find(params[:id])
  end

  def resend
    @watcher = Watcher.find(params[:id])

    Mailer.confirmation(@watcher.id, @watcher.email).deliver_later

    flash[:notice] = "We've sent another confirmation e-mail."
    redirect_to pending_confirmation_path(@watcher)
  end

  def confirm
    watcher_id = WatcherToken.parse(params[:token])

    unless watcher_id
      redirect_to root_path, alert: "Invalid confirmation token."
      return
    end

    @watcher = Watcher.find(watcher_id)
    @watcher.update!(email_confirmed: true)

    RetrieveMostRecentCursorJob.perform_later(@watcher.id) unless @watcher[:cursor]
  end
end
