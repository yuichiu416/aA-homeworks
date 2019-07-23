class ArtworksController < ApplicationController
    protect_from_forgery with: :null_session
    def index
        if params[:id]
            render json: Artwork.all
        else
            artworks = Artwork.all.where("#{:artist_id} = #{params[:user_id]}")
            if artworks.empty?
                render plain: "it's empty"
            else
                render json: artworks
            end
        end

    end


    def create
        artwork = Artwork.new(artwork_params)
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
        artwork = Artwork.find(params[:id])
        if artwork.update_attributes(artwork_params)
            render json: artwork
        else
            render json: artowrk.errors, status: 404
        end
    end

    def destroy
        artwork = Artwork.find(params[:id])
        artwork.destroy
        render json: artwork 
    end

  private
    def artwork_params
        params.require(:artowrk).permit(:title, :artist_id)
    end
end