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
    @likes = Like.where(user_id: current_user.id).order('created_at DESC').includes(:post)
    posts = like_post(@likes)
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(12)
  end

  private

  def like_params
    @post = Post.find(params[:id])
  end

  def like_post(likes)
    @post = []
    likes.each do |like|
      @post << like.post
    end
    @post
  end
end
