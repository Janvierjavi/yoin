class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :set_user, only: %i[show edit update destroy]
  
  def new
    if logged_in?
      redirect_to user_url(current_user.id)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # とりあえずリダイレクト
      session[:user_id] = @user.id
      redirect_to user_url(@user.id), notice: "ログインに成功しました"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(current_user.id), notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to new_user_url, notice: "またね"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :bio)
  end

  def set_user
    @user = current_user
  end

end
