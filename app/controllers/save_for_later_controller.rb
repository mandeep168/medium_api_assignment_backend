class SaveForLaterController < ApplicationController
    before_action :authorize_request

    def mark
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
            message = "This has already been saved for later"
        end
        render json: {
            message: message
        }
    end

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
