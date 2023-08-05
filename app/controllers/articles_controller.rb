class ArticlesController < ApplicationController
    before_action :authorize_request, except: %i[getarticles estimate_reading_time]
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

    def view_article 
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
        if topic.nil?
            topic = Topic.new()
            topic.name = params[:topic_name]
            topic.save
        end
        @article.topic_id = topic.id
        @article.user_id = @current_user.id
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
        if post.destroy
            render json: {message: "post deleted successfully"}, status: :ok
        else 
            render json: {error: post.error.full_messages}, status: :unprocessable_entity
        end
    end

    def get_my_articles
        my_posts = []
        for article in @current_user.articles 
            # article => post, likes_count, comment_count, views_array 
            article_obj = {
                'article': article,
                'likes_count': article.likes.count,
                'comments_count': article.comments.count,
                'views': View.where(article_id: article.id)
            }
            my_posts << article_obj
        end
        render json: my_posts
    end

    # filtering articles by author
    def filter_by_user
        articles = User.find(params[:id]).articles
        render json: articles
    end

    # filtering articles within date range
    def filter_by_date
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        if start_date.nil? || end_date.nil? 
            render json: {
                error: "Invalid date format"
            }
        else 
            articles = Article.where(updated_at:start_date.beginning_of_day..end_date.end_of_day)
            render json: articles
        end
    end

    def search 
        articles = [];
        search_term = params[:search_term]
        for item in Article.where("title LIKE ?", "%#{search_term}%")
            articles << item 
        end
        for item in Profile.where("name LIKE ?", "%#{search_term}%")
            for item_1 in item.user.articles 
                unless articles.include?(item_1)
                    articles << item_1
                end
            end
        end
        for item in Topic.where("name LIKE ?", "%#{search_term}%")
            unless articles.include?(item)
                articles << item 
            end 
        end
        render json: articles
    end

    def sort_by_likes_count
        sorted_posts = Article.left_joins(:likes).select('articles.*, COUNT(likes.id) AS likes_count').group(:id).order('COUNT(likes.id) DESC')
        render json: sorted_posts
    end

    def sort_by_comments_count
        sorted_posts = Article.left_joins(:comments).select('articles.*, COUNT(comments.id) AS comments_count').group(:id).order('COUNT(comments.id) DESC')
        render json: sorted_posts
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
