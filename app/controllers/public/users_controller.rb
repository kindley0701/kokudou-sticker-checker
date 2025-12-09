class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def mypage
    checked_sticker_ids = current_user.checks.pluck(:sticker_id)
    @flg = params[:check_flg] || 'all'
    if @flg == 'not_get'
      @shops = Shop.where.not( sticker_id: checked_sticker_ids )
    elsif @flg == 'got'
      @shops = Shop.where( sticker_id: checked_sticker_ids )
    else
      @shops = Shop.all
    end
  end
end
