# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :find_article, except: %i[create index]

  def index
    articles = Article.all
    render json: { articles: articles }, status: :ok
  end

  def show
    comments = Comment.where(article_id: params[:id])
    render json: {
      article: @article.as_json.merge("comments": comments)
    }, status: :ok
  end

  def create
    article = Article.new(article_params.merge(user_id: @current_user.id))

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
    if @article['user_id'] == @current_user.id
      @article&.update(article_params)
      render json: { message: 'Article successfully updated' }, status: :ok
    else
      render json: {
        message: 'You have to be the owner to update this article'
      }, status: :forbidden
    end
  end

  def destroy
    if @article['user_id'] == @current_user.id
      @article&.destroy
      render json: { message: 'Article successfully deleted' }, status: :ok
    else
      render json: {
        message: 'You have to be the owner to delete this article'
      }, status: :forbidden
    end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  rescue StandardError => e
    render json: {
      errors: e.message
    }, status: :bad_request
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
