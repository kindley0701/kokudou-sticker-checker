class Admins::HomesController < ApplicationController
  def top
    @stickers = Sticker.all
  end
end
