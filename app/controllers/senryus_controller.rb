class SenryusController < ApplicationController
  def index
    @senryus = Senryu.all
  end

  def new
    @senryu = Senryu.new
  end

  def create
    @senryu = Senryu.new(senryu_params)
    if @senryu.save
      redirect_to senryus_url, notice: "posted successfully"
    else
      render 'new'
    end
  end

  def destroy
    set_senryu
    @senryu.destroy
    redirect_to senryus_url, notice: "deleted successfully"
  end

  private

  def senryu_params
    params.require(:senryu).permit(:content)
  end

  def set_senryu
    @senryu = Senryu.find(params[:id])
  end
end
