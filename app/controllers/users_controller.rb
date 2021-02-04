class UsersController < ApplicationController
  def show
    @post_all = Post.with_attached_images.includes(:user)
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @posts = @post_all.where(user_id: @user).order('created_at DESC').page(params[:page]).per(12)
  end
end
