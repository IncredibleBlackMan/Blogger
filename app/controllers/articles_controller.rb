# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles }, status: :ok
  end

  def show
    binding.pry
    article = Article.find(params[:id])
    render json: { article: article }, status: :ok
  end

  def create
    article = Article.new!(article_params.merge(user_id: @current_user.id))

    if article.save
      render json: {
        message: 'Article created successfully',
        article: article
      }, status: :created
    else
      render json: {
        errors: article.errors.full_messages
      }, status: :bad_request
    end
  end

  def update
    article = Article.find(params[:id])

    article&.update(article_params)
    render json: { message: 'Article successfully updated' }, status: :ok
  rescue StandardError => e
    render json: {
      message: 'An error occurred while updating article',
      errors: e.message
    }, status: :bad_request
  end

  def destroy
    article = Article.find(params[:id])

    article&.destroy
    render json: { message: 'Article successfully deleted' }, status: :ok
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
