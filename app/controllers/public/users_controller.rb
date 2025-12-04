class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def mypage
    checked_sticker_ids = current_user.checks.pluck(:sticker_id)
    @shops = params[:check_flg].present? ? Shop.where.not(sticker_id: checked_sticker_ids ) : Shop.all
    @flg = params[:check_flg].present? ? true : false
  end
end
