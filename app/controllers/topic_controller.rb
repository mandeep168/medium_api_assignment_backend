class TopicController < ApplicationController
    before_action :authorize_request

    def view_topics
        topics = [] 
        for topic in Topic.all 
            topics << topic.name 
        end 
        if topics.empty? 
            render json: {
                message: "No topics to show"
            }
        else 
            render json: {
                data: topics 
            }
        end
    end

end
