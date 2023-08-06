class ArticlesController < ApplicationController
    before_action :authorize_request, except: %i[getarticles estimate_reading_time]
    before_action :post_exists_check, only: [:comment_article, :delete_article, :edit_article]
    before_action :user_authorized_to_perform_action_check, only: [:delete_article, :edit_article]
    ActiveStorage::Current.host = "http://localhost:3000"

    def user_authorized_to_perform_action_check
        unless Article.find(params[:id]).user_id == @current_user.id 
            render json: response = {
                message: "You are not authorized to perform the action"
            }
        end
    end

    def post_exists_check 
        unless Article.exists?(id: params[:id])
            render json: response = {
                message: "Post does not exist"
            }
        end
    end

    def create_article
        @article = Article.new(article_params) 
        topic = Topic.where(name: params[:topic_name])
        if topic.empty?
            topic = Topic.new()
            topic.name = params[:topic_name]
            topic.save
        end
        @article.topic_id = topic.id
        @article.user_id = @current_user.id
        @article.image.attach(params[:image]) if params[:image].present?
        @article.estimatedtime = estimate_reading_time(@article.content)
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

        if post.views.delete_all && post.comments.delete_all && post.likes.delete_all && post.saveforlaters.delete_all && post.userlists.delete_all
            post.destroy
            render json: {message: "post deleted successfully"}, status: :ok
        else 
            render json: {error: post.error.full_messages}, status: :unprocessable_entity
        end
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

    def add_view_to_article 
        view = View.where(article_id: params[:id], user_id: @current_user.id)
        if view[0].nil? 
            view = View.new
            view.user_id = @current_user.id
            view.article_id = params[:id]
            view.save
        end
        render json: view
    end

    def comment_article
        comment = Comment.where(article_id: params[:id], user_id: @current_user.id)
        if comment.empty? 
            comment = Comment.new()
            comment.content = params[:content]
            comment.user_id = @current_user.id
            comment.article_id = params[:id].to_i
            comment.save
            response = {
                message: "Comment created",
                date: comment
            }
        else 
            comment = comment.first
            comment.content = params[:content]
            comment.save
            response = {
                message: "Comment Updated",
                data: comment
            }
        end
        render json: response
    end

    def estimate_reading_time(text, words_per_minute = 200)
        word_count = text.split.size
        estimated_time = (word_count.to_f / words_per_minute).ceil
        estimated_time.to_s
    end

    def article_params
        params.permit(:title, :content)
    end
end
