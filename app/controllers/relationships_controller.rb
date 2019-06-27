class RelationshipsController < ApplicationController
  respond_to? :js

  def create
    @user = User.find(params.dig(:relationship, :followed_id))
    current_user.follow!(@user)
    @user.reload
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    @user.reload
  end
end
