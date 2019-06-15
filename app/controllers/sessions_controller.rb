class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        # とりあえずユーザーページにリダイレクト（あとで変更する）
        redirect_to user_url(@user.id), notice: "ログインに成功しました"
    else
        flash[:notice] = 'ログインに失敗しました'
        render 'new'
    end
  end

  def destroy
  end
end
