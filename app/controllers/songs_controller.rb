class SongsController < ApplicationController
  def create
    @artist = Artist.find(params[:artist])
    @song = Song.new(params[:song])
  end
end
