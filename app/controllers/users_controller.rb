class UsersController < ApplicationController
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
  end

  def show
    @user = current_user
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :bio)
  end

end
