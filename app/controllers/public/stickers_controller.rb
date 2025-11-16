class Public::StickersController < ApplicationController
  def index
    @stickers = Sticker.all
  end

  def show
    @sticker = Sticker.find(params[:id])
    @shops = @sticker.shops
  end
end
