class WatchersController < ApplicationController
  def new
    @watcher = Watcher.new
  end

  def create
    @watcher = Watcher.new(watcher_params)

    if @watcher.save
      Mailer.confirmation(@watcher.id, @watcher.email).deliver_later
      redirect_to pending_confirmation_path(@watcher)
    else
      render :new
    end
  end

  private def watcher_params
    params
      .require(:watcher)
      .permit(:frequency, :email, :wallet_address)
  end
end
