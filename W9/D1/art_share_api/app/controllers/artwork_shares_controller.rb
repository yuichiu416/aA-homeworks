class ArtworkSharesController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        render json: Artwork.all

    end

    def create
        # return render json: params
        artwork = ArtworkShare.new(artwork_share_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        # 422 is the status code for an unprocessable entity.
        # You can either pass the status code or status symbol.
        # In other words, you can also return:
        # render json: artwork.errors.full_messages, status: 422
        end
    end

    def update
        artwork_share = ArtworkShare.find(params[:id])
        if artwork_share.update_attributes(artwork_share_params)
            render json: artwork_share
        else
            render json: artowrk.errors, status: 404
        end
    end

    def destroy
        artwork_share = ArtworkShare.find(params[:id])
        artwork_share.destroy
        render json: artwork_share 
    end

  private
    def artwork_share_params
        params.require(:artwork_share).permit(:artwork_id, :viewer_id)
    end
end