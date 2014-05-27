class ConcertPhotosController < ApplicationController

  def create
    @concert = Concert.find(params[:concert_id])
    @concert_photo = @concert.concert_photos.build(concert_photo_params)

    if @concert_photo.save
      flash[:success] = "Photo uploaded!"
      redirect_to @concert
    else
      flash[:error] = "There was a problem uploading your photo."
      redirect_to back
    end
  end

  private

    def concert_photo_params
      params.require(:concert_photo).permit(:image, :user_id)
    end
end