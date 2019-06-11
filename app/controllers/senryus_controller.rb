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
  end

  private

  def senryu_params
    params.require(:senryu).permit(:content)
  end
end
