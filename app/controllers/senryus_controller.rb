class SenryusController < ApplicationController
  def index
    @senryus = Senryu.all
  end

  def new
    if params[:senryu].present?
      @senryu_with_errors = Senryu.create(senryu_content)
      @senryu = Senryu.new(senryu_content_without_initial)
      
      @first_initial = params[:senryu][:first_initial]
      @second_initial = params[:senryu][:second_initial]
      @third_initial = params[:senryu][:third_initial]
    else
      @senryu = Senryu.new
    end
  end

  def create
    @senryu = Senryu.new(senryu_content)
    if @senryu.save
      redirect_to senryus_url, notice: "posted successfully"
    else
      redirect_to new_senryu_url(senryu: senryu_params)
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

  def senryu_content_without_initial
    {
      "first_line": senryu_params[:first_line], 
      "second_line": senryu_params[:second_line], 
      "third_line": senryu_params[:third_line]
    }
  end

  def set_senryu
    @senryu = Senryu.find(params[:id])
  end
end
