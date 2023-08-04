class ArticlesController < ApplicationController
    before_action :authorize_request, except: :getarticles
    def getarticles 
        render json: Article.all
    end

    def like_article 
        like = Like.where(article_id: params[:id], user_id: @current_user.id)
        if like[0].nil? 
            like = Like.new
            like.user_id = @current_user.id
            like.article_id = params[:id]
            like.save
        end
        render json: like
    end

    def comment_article 
        comment = Like.where(article_id: params[:id], user_id: @current_user.id)
        if comment[0].nil? 
            comment = Like.new(params[:content])
            comment.user_id = @current_user.id
            comment.article_id = params[:id]
            comment.save
        end
        render json: comment
    end

    def create_article
        @article = Article.new(article_params) # to do -> can we include topic in it
        topic = Topic.find_by(name: params[:name])
        unless topic
            puts "inside unless"
            topic = Topic.new(params[:name])
            topic.save
        end
        puts "Topic: " 
        puts topic.id
        @article.topic_id = topic.id
        @article.user_id = @current_user.id
        @article.save
        if @article
            render json: @article, status: :created
          else
            render json: { errors: @article.errors.full_messages },
                   status: :unprocessable_entity
          end
    end

    def edit_article
        post = @current_user.articles.find(params[:id])
        if params[:title]
            post.title = params[:title]
        end
        if params[:content]
            post.content = params[:content]
        end
        post.save
        if post 
            render json: post, status: :ok
        else
            render json: {error: post.error.full_messages}, status: :unprocessable_entity
        end
    end    

    def delete_article
        post = @current_user.articles.find(params[:id])
        if post.destroy
            render json: {message: "post deleted successfully"}, status: :ok
        else 
            render json: {error: post.error.full_messages}, status: :unprocessable_entity
        end

    end

    def article_params
        params.permit(:title, :content)
    end
end
