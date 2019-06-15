class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # とりあえずリダイレクト
      redirect_to senryus_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    # params[:user].delete(:password) if params[:user][:password].blank?
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
