class ArticlesController < ApplicationController
    before_action :authorize_request, except: :getarticles
    def getarticles 
        render json: Article.all
    end

    def create_article
        @article = Article.new(article_params)
        @article.user_id = @current_user.id
        @article.save
        if @article
            render json: @article, status: :created
          else
            render json: { errors: @article.errors.full_messages },
                   status: :unprocessable_entity
          end
    end

    def article_params
        params.permit(:title, :content)
    end
end
