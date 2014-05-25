class PagesController < ApplicationController
  def index
  end

  def search
    @band = params[:band]

    mbid = Musicbrainz.search(@band)
    if mbid
      @results = Setlist.search(mbid)
      Artist.where(name: @band).first_or_create
    else
      flash[:warning] = "Sorry - we couldn't find an artist with that name."
      render :index
    end
  end

  def search_youtube
    @band = Artist.where(name: params[:band]).first_or_create
    search_params = params[:concert].split(', ')
    @venue = Venue.where(name: search_params[2], city: search_params[3], state: search_params[4]).first_or_create
    @concert = Concert.where(date: search_params[0], venue_id: @venue.id).first_or_create
    @concert_artist = ConcertArtist.where(concert_id: @concert.id, artist_id: @band.id).first_or_create
    @songs = params[:songs]
    @date = @concert.date.strftime('%B %e %Y')
    @tour = search_params[1]
    #@venue = venue.name
    #@city = venue.city.strftime
    #@state = venue.state

    search1 = "#{@band.name}, #{@venue.name}, #{@venue.state}, #{@date}"
    search2 = "#{@band.name}, #{@venue.name}, #{@date}"
    search3 = "#{@band.name}, #{@venue.state}, #{@date}"

    @titles_ids = {}

    results = []

    results << Youtube.search(search1)
    results << Youtube.search(search2)
    results << Youtube.search(search3)

    results.flatten!.uniq!

    results.each do |result|
      if result =~ /\(\w*\)\z/
        title = result.gsub(/ \(\w*\)\z/, '')
        @titles_ids[title] = result[/\(\w*\)\z/].gsub(/\(*\)*/, '')
        # @ids << result[/\(\w*\)\z/].gsub(/\(*\)*/, '')
      end
    end
  end

  def make_concert

  end
end
