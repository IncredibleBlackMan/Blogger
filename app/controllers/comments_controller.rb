# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, except: :create

  def create
    comment = Comment.new(comment_params
                              .merge(user_id: @current_user.id,
                                     article_id: params[:article_id]))

    if comment.save
      render json: { message: 'Comment created successfully' }, status: :created
    else
      render json: {
        errors: comment.errors.full_messages
      }, status: :bad_request
    end
  end

  def update
    if @comment['user_id'] == @current_user.id
      @comment&.update(comment_params)
      render json: { message: 'Comment successfully updated' }, status: :ok
    else
      render json: {
        message: 'You have to be the owner to delete this comment'
      }, status: :forbidden
    end
  end

  def destroy
    if @comment['user_id'] == @current_user.id
      @comment&.destroy
      render json: { message: 'Comment successfully deleted' }, status: :ok
    else
      render json: {
        message: 'You have to be the owner to update this comment'
      }, status: :forbidden
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  rescue StandardError => e
    render json: {
      errors: e.message
    }, status: :bad_request
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
