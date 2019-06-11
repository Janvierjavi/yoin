class SenryusController < ApplicationController
  def index
    @senryus = Senryu.all
  end

  def new
    @senryu = Senryu.new
  end

  def create
    @senryu = Senryu.new(senryu_content)
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
    params.fetch(:senryu, {}).permit %i[first_initial first_line second_initial second_line third_initial third_line]
  end

  def senryu_content
    {
      "first_line": senryu_params[:first_initial] + senryu_params[:first_line], 
      "second_line": senryu_params[:second_initial] + senryu_params[:second_line], 
      "third_line": senryu_params[:third_initial] + senryu_params[:third_line]
    }
  end

  def set_senryu
    @senryu = Senryu.find(params[:id])
  end
end
