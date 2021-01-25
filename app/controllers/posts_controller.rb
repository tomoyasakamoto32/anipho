class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :new_guest]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :root_to_path, only: [:edit, :destroy]


  def index
    @posts = Post.includes(:user).order('created_at DESC').page(params[:page]).per(12)
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

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  def search
    @posts = Post.search(params[:keyword]).page(params[:page]).per(12)
  end

  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
    user.nickname = "ゲスト"
    user.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end


  private
  def post_params
    params.require(:post).permit(:title, :explanation, :animal_name, :category_id, images: []).merge(user_id: current_user.id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def root_to_path
    if @post.id = nil || current_user.id != @post.user.id
      redirect_to root_path
    end
  end
end