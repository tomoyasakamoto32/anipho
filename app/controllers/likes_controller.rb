class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :like_params, except: :index

  def create
    Like.create(user_id: current_user.id, post_id: params[:id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:id]).destroy
  end

  def index
    @likes = Like.where(user_id: current_user.id).includes(:post)
  end

  private

  def like_params
    @post = Post.find(params[:id])
  end
end
