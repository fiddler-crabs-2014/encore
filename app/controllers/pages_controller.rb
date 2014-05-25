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
    band = params[:band]
    search_params = params[:concert].split(', ')
    venue = Venue.where(name: search_params[2], city: search_params[3], state: search_params[4]).first_or_create
    concert = Concert.where(date: search_params[0], venue_id: venue.id).first_or_create

    @songs = params[:songs]
    @band = band
    @date = concert.date
    @tour = search_params[1]
    @venue = venue.name
    @city = venue.city
    @state = venue.state

    date, tour, venue, city, state = search_params
    search1 = "#{band}, #{venue}, #{state}, #{date}"
    search2 = "#{band}, #{venue}, #{date}"
    search3 = "#{band}, #{state}, #{date}"

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
    render :search_youtube
  end

  def make_concert

  end
end
