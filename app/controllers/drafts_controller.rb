class DraftsController < ApplicationController
    before_action :authorize_request

    def save_or_update_draft 
        draft = Draft.find_by(user_id: @current_user.id) 
        if draft.nil?
            draft = Draft.new()
            draft.user_id = @current_user.id 
        end 
        draft.title = params[:title]
        draft.content = params[:content]
        draft.save 
        render json: {
            message: "Draft saved or updated",
            data: draft
        }
    end 

    def get_draft
        draft = Draft.find_by(user_id: @current_user.id) 
        if draft.nil?
            response = {
                message: "No drafts saved"
            }
        else 
            response = {
                data: draft 
            }
        end 
        render json: response
    end
end
