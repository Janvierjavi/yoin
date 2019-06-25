class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i[new create]

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to home_senryus_url, notice: I18n.t('controllers.notices.logged_in')
    else
        flash[:notice] = I18n.t('controllers.notices.login_failed')
        render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = I18n.t('controllers.notices.logged_out')
    redirect_to new_session_path
  end
end
