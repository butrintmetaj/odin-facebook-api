class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :like, :unlike]

  def index
    # not final
    render json: { data: Post.all }, status: :ok
  end

  def create
    @post = @current_user.posts.new(post_params)

    if @post.save
      render json: { data: @post }, status: :created
    else
      render json: { message: 'Could not create post' }, status: :unprocessable_entity
    end
  end

  def show
    render json: { data: @post }, status: :ok
  end

  def update
    authorize(@post)

    if @post.update(post_params)
      render json: { data: @post }, status: :ok
    else
      render json: { message: 'Could not update post' }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@post)

    if @post.destroy
      render json: { data: {}, message: 'Post deleted' }, status: :ok
    else
      render json: { message: 'Could not delete post' }, status: :unauthorized
    end
  end

  def like
    if @post.like(@current_user.id)
      render json: { data: {}, message: 'Post liked' }, status: :created
    else
      render json: { error: 'Post already liked' }, status: :unprocessable_entity
    end
  end

  def unlike
    if @post.unlike(@current_user.id)
      render json: { data: {}, message: 'Post unliked' }, status: :ok
    else
      render json: { error: 'Like does not exist' }, status: :unauthorized
    end
  end

  private

  def post_params
    params.permit(:body, :image)
  end

  private

  def set_post
    @post ||= Post.find(params[:id])
  end
end
