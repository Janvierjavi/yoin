class SenryusController < ApplicationController
  def discover
    @senryus = Senryu.in_discover(params).timeline
  end

  def home
    @senryus = Senryu.all.includes(:user, :favorites).subscribed_and_mine(current_user.following, current_user).timeline
  end

  def new
    if params[:senryu].present?
      @senryu_with_errors = current_user.senryus.build(senryu_content)
      @senryu_with_errors.save
      @senryu = current_user.senryus.build(senryu_content_without_initial)
      
      @first_initial = params.dig(:senryu, :first_initial)
      @second_initial = params.dig(:senryu, :second_initial)
      @third_initial = params.dig(:senryu, :third_initial)
    else
      @senryu = Senryu.new
    end
  end

  def create
    @senryu = current_user.senryus.build(senryu_content)
    if @senryu.save
      redirect_to home_senryus_url, notice: I18n.t('controllers.notices.posted_senryu')
    else
      redirect_to new_senryu_url(senryu: senryu_params)
    end
  end

  def destroy
    set_senryu
    @senryu.destroy
    redirect_to home_senryus_url, notice: I18n.t('controllers.notices.deleted_senryu')
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
