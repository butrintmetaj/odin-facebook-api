class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy, :like, :unlike]
  before_action :set_post, only: [:index, :create]

  def index
    render json: { data: @post }, status: :ok
  end

  def create
    @comment = @post.comments.new(body: params[:body], user_id: @current_user.id)

    if @comment.save
      render json: { data: @comment }, status: :created
    else
      render json: { message: 'Could not create comment' }, status: :unprocessable_entity
    end
  end

  def show
    render json: { data: @comment }, status: :ok
  end

  def update
    authorize(@comment)

    if @comment.update(body: params[:body])
      render json: { data: @comment }, status: :ok
    else
      render json: { message: 'Could not update comment' }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@comment)

    if @comment.destroy
      render json: { data: {}, message: 'Comment deleted' }, status: :ok
    else
      render json: { message: 'Could not delete comment' }, status: :unauthorized
    end
  end

  def like
    if @comment.like(@current_user.id)
      render json: { data: {}, message: 'Comment liked' }, status: :created
    else
      render json: { error: 'Comment already liked' }, status: :unprocessable_entity
    end
  end

  def unlike
    if @comment.unlike(@current_user.id)
      render json: { data: {}, message: 'Comment unliked' }, status: :ok
    else
      render json: { error: 'Like does not exist' }, status: :unauthorized
    end
  end

  private

  def set_comment
    @comment ||= Comment.find(params[:id])
  end

  private

  def set_post
    @post ||= Post.includes(:comments).find(params[:post_id])
  end
end
