class RelationshipsController < ApplicationController
  respond_to? :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    current_user.reload
    @user.reload
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    current_user.reload
    @user.reload
  end
end
