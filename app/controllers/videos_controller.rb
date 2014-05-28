class VideosController < ApplicationController
  respond_to :html, :js

  def report
    @video = Video.find(params[:id])

    @video.update(correct: false)
  end

  private

    # def video_params
    #   params.require(:video).permit(:id)
    # end
end