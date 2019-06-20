class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :set_user, only: %i[edit update destroy following followers collection]
  
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
    not_allow
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(current_user.id), notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @senryus = @user.senryus.timeline
  end

  def destroy
    @user.destroy
    redirect_to new_user_url, notice: "またね"
  end

  def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

  def collection
    @senryus = @user.in_collection(params).timeline
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache, :bio)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def not_allow
    redirect_to user_url(current_user.id) unless @user == current_user
  end
end
