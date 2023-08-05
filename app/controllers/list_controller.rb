class ListController < ApplicationController
    before_action :authorize_request

    def list_params 
        params.permit(:name)
    end

    def create_list
        list = List.new(list_params)
        list.user_id = @current_user.id 
        if list.save 
            render json: {
                message: "List created successfully",
                list: list
            }
        else 
            render json: {
                error: "Error while creating List, List not created"
            }
        end
    end

    def add_article_to_list
        userlist = Userlist.where(article_id: params[:article_id], list_id: params[:list_id])
        if userlist.length != 0
            render json: {
                message: "Article already existes in the list"
            }
        else
            userlist = Userlist.new();
            userlist.article_id = params[:article_id]
            userlist.list_id = params[:list_id]

            if userlist.save 
                render json: {
                    message: "Article added to List",
                    userlist: userlist
                }
            else 
                render json: {
                    error: "Error while adding article to list",
                }
            end
        end
    end

    def view_all_lists
        lists = @current_user.lists
        if lists.length == 0
            response = {
                message: "User has not created any list"
            }
        else
            response = {
                data: lists
            }
        end
        render json: response
    end

    def view_list
        articles = Userlist.where(list_id: params[:id])
        list_articles = []
        for article in articles
            list_articles << Article.find(article.article_id)
        end
        if list_articles.length != 0
            render json: {
                data: list_articles
            }
        else 
            render json: {
                message: "There are no articles in this list"
            }
        end
    end
end
