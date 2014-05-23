class WelcomeController < ApplicationController

  def index

  end

  def search
    band_name = params[:band]
    mbid = Musicbrainz.search(band_name)
    @results = Setlist.search(band_name, mbid)
    p mbid

    p @results
    # venue = params[:venue][:name]
    # location = params[:venue][:location]

    # date = Date.parse(params[:concert][:date]).strftime("%B %e %Y")

    # search1 = "#{band_name}, #{venue}, #{location}, #{date}"
    # search2 = "#{band_name}, #{venue}, #{date}"
    # search3 = "#{band_name}, #{location}, #{date}"

    # @user = current_user

    #@results = Setlist.search(band_name)
  end

end
