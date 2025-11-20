class Public::ChecksController < ApplicationController
  def create
    @sticker = Sticker.find(params[:sticker_id])
    check = current_user.checks.new(sticker_id: @sticker.id)
    check.save
    respond_to do |format|
      format.turbo_stream
      format.html {redirect_to stickers_path}
    end
  end
  def destroy
    @sticker = Sticker.find(params[:sticker_id])
    check = current_user.checks.find_by(sticker_id: @sticker.id)
    check.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to stickers_path }
    end
  end
end
