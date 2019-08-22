class PhotosController < ApplicationController
    before_action :authenticate_user!

    def create
      @place = Photo.find(params[:place_id])
      @place.photos.create(photo_params.merge(user: current_user))
      redirect_to place_photos_path(@place)
    end
  
    private
  
    def photos_params
      params.require(:photo).permit(:picture)
    end
end