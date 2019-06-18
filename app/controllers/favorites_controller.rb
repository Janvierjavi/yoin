class FavoritesController < ApplicationController
  before_action :set_senryu

  def create
    @favorite = Favorite.create(user_id: current_user.id, senryu_id: params[:senryu_id])
    @senryu.reload
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, senryu_id: params[:senryu_id])
    favorite.destroy
    @senryu.reload
  end

  private

  def set_senryu
    @senryu = Senryu.find(params[:senryu_id])
  end

end
