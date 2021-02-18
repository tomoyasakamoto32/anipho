class RelationshipsController < ApplicationController
  before_action :set_user, except: [:index, :followings, :followers]
  before_action :authenticate_user!

  def create
    following = current_user.follow(@user)
    following.save
  end

  def destroy
    following = current_user.unfollow(@user)
    following.destroy
  end

  def index
    @post_all = Post.with_attached_images.includes(:user)
    @users = current_user.followings
    @posts = @post_all.where(user_id: @users).order('created_at DESC').page(params[:page]).per(12)
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
