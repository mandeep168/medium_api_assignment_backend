class SaveForLaterController < ApplicationController
    before_action :authorize_request

    # method for adding or deleting articles to saved for later section
    def mark_and_unmark
        saveforlater = Saveforlater.where(user_id: @current_user.id, article_id: params[:id])
        if saveforlater.empty?
            saveforlater = Saveforlater.new()
            saveforlater.user_id = @current_user.id 
            saveforlater.article_id = params[:id]
            if saveforlater.save 
                message = "Article is saved for later"
            else 
                message = "Error occured while save the article for later"
            end
        else 
            saveforlater.first.destroy
            message = "Article removed from save for later"
        end
        render json: {
            message: message
        }
    end

    # method for viewing articles in saved for later section
    def view
        articles = []
        for item in Saveforlater.where(user_id: @current_user)
            articles << Article.find(item.article_id)
        end 
        if articles.empty?
            render json: {
                message: "No articles are saved for later"
            }
        else 
            render json: {
                data: articles
            }
        end
    end
end
