class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end


  private
  def post_params
    params.require(:post).permit(:image, :title, :explanation, :animal_name, :category_id).merge(user_id: current_user.id)
  end
end