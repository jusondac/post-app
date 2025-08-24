class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_role, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :check_post_owner, only: [ :edit, :update, :destroy ]

  def index
    @posts = Post.includes(:user, :publisher).published.order(created_at: :desc)
  end

  def my_posts
    @q = current_user.posts.includes(:publisher).ransack(params[:q])
    @posts = @q.result.order(created_at: :desc)
    @filter = params[:filter] || "all"

    case @filter
    when "draft"
      @posts = @posts.draft
    when "published"
      @posts = @posts.published
    end

    @posts = @posts.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @post = current_user.posts.build
    @publishers = Publisher.active.order(:name)
  end

  def create
    @post = current_user.posts.build(post_params)

    # Handle draft button
    if params[:draft]
      @post.status = "draft"
    end

    if @post.save
      if @post.draft?
        redirect_to @post, notice: "Post was successfully saved as draft."
      else
        redirect_to @post, notice: "Post was successfully published."
      end
    else
      @publishers = Publisher.active.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @publishers = Publisher.active.order(:name)
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      @publishers = Publisher.active.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :publisher_id, :status)
  end

  def check_user_role
    unless current_user.can_create_posts?
      redirect_to root_path, alert: "You do not have permission to perform this action."
    end
  end

  def check_post_owner
    unless @post.user == current_user
      redirect_to posts_path, alert: "You can only edit your own posts."
    end
  end
end
