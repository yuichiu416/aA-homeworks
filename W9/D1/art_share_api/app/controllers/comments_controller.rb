class CommentsController < ApplicationController
    protect_from_forgery with: :null_session
    def create
        # return render json:params
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else
            render json: comment.errors.full_messages, status: 404
        end
    end

    def index
        render json: Comment.all
    end

    def update
        comment = Comment.find(params[:id])
        if comment.update_attributes(comment_params)
            render json: comment
        else
            render json: comment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end

    private
    def comment_params
        params.require(:comment).permit(:body, :user_id, :artwork_id)
    end
end
