class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :new_guest, :category]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :root_to_path, only: [:edit, :destroy]


  def index
    @posts = Post.with_attached_images.includes(:user, :likes).order('created_at DESC').page(params[:page]).per(12)
  end

  def new
    @post = PostsTag.new
  end

  def create
    @post = PostsTag.new(post_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @tags = @post.tags
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    @form = PostsTag.new(title: @post.title, animal_name: @post.animal_name, category_id: @post.category_id, 
      explanation: @post.explanation)
  end

  def update
    @form = PostsTag.new(update_params)
    if @form.valid?
      @form.update
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
    @posts = Post.with_attached_images.includes(:user, :likes).search(params[:keyword]).order('created_at DESC').page(params[:page]).per(12)
  end

  def new_guest
    user = User.find_or_create_by(email: 'guest@example.com') do |user|
    user.nickname = "ゲスト"
    user.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def category
    @post = Post.find_by(category_id: params[:id])
    @posts = Post.with_attached_images.includes(:user, :likes).where(category_id: params[:id]).order('created_at DESC').page(params[:page]).per(12)
  end


  private
  def post_params
    params.require(:posts_tag).permit(:title, :explanation, :animal_name, :category_id, :name, images: []).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:posts_tag).permit(:title, :explanation, :animal_name, :category_id, :name, images: []).merge(user_id: current_user.id, post_id: params[:id])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def root_to_path
    if @post.id == nil || current_user.id != @post.user.id
      redirect_to root_path
    end
  end
end