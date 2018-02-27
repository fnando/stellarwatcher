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

  def edit
    @watcher = Watcher.find(params[:id])
  end

  def update
    @watcher = Watcher.find(params[:id])

    if @watcher.update(watcher_params)
      redirect_to edit_watcher_path(@watcher), notice: "Your subscription has been updated!"
    else
      render :edit
    end
  end

  private def watcher_params
    params
      .require(:watcher)
      .permit(:frequency, :email, :wallet_address, :webhook_url)
  end
end
