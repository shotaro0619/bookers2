class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def followings
     @users = User.find(params[:user_id]).followings

  end

  def followers
     @users = User.find(params[:user_id]).followers
  end
end
