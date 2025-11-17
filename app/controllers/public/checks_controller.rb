class Public::ChecksController < ApplicationController
  def create
    @sticker = Sticker.find(params[:sticker_id])
    @check = current_user.checks.new(sticker_id: @sticker.id)
    @check.save
    redirect_to stickers_path
  end
  def destroy
    @sticker = Sticker.find(params[:sticker_id])
    @check = current_user.checks.find_by(sticker_id: @sticker.id)
    @check.destroy
    redirect_to stickers_path
  end
end
