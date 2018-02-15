class SubscriptionsController < ApplicationController
  def remove
    @watcher = Watcher.find(ConfirmationToken.parse(params[:token]))
  end

  def destroy
    @watcher = Watcher.find(ConfirmationToken.parse(params[:token]))
    @watcher.destroy!

    redirect_to root_path, notice: "You won't receive any new notifications."
  end
end
