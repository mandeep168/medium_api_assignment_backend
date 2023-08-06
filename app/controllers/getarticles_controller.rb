class GetarticlesController < ApplicationController
    before_action :authorize_request, except: %i[getarticles estimate_reading_time]
    before_action :post_exists_check, only: [:comment_article, :delete_article, :edit_article]
    def get_articles_in_format(articles)
        formated_articles = []
        for article in articles 
            formated_articles << format_article(article)
        end
        formated_articles
    end

    def format_article(article)
        ActiveStorage::Current.host = "http://localhost:3000"
        article_obj = {
                'id': article.id,
                'title': article.title,
                'content': article.content,
                'published date': article.updated_at,
                'image': article.image.url,
                'likes_count': article.likes.count,
                'comments_count': article.comments.count,
                'views': article.views,
                'likes': article.likes,
                'comments': article.comments,
            }
    end

    
    def getarticles 
        render json: get_articles_in_format(Article.all)
    end

    def get_my_articles
        render json: get_articles_in_format(@current_user.articles)
    end

    # filtering articles by author
    def filter_by_user
        articles = User.find(params[:id]).articles
        articles = get_articles_in_format(articles)
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
            articles = get_articles_in_format(articles)
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
        render json: get_articles_in_format(articles)
    end

    def sort_by_likes_count
        sorted_posts = Article.left_joins(:likes).select('articles.*, COUNT(likes.id) AS likes_count').group(:id).order('COUNT(likes.id) DESC')
        render json: get_articles_in_format(sorted_posts)
    end

    def sort_by_comments_count
        sorted_posts = Article.left_joins(:comments).select('articles.*, COUNT(comments.id) AS comments_count').group(:id).order('COUNT(comments.id) DESC')
        render json: get_articles_in_format(sorted_posts)
    end

end
