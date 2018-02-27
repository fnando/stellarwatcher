class SubscriptionsController < ApplicationController
  def edit
    @watcher = Watcher.find(WatcherToken.parse(params[:token]))
    redirect_to edit_watcher_path(@watcher)
  end

  def remove
    @watcher = Watcher.find(WatcherToken.parse(params[:token]))
  end

  def destroy
    @watcher = Watcher.find(WatcherToken.parse(params[:token]))
    @watcher.destroy!

    redirect_to root_path, notice: "You won't receive any new notifications."
  end
end
