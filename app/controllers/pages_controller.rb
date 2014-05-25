class PagesController < ApplicationController
  def index
  end

  def search
    @band = params[:band]
    mbid = Musicbrainz.search(@band)
    if mbid
      @results = Setlist.search(mbid)
    else
      flash[:warning] = "Sorry - we couldn't find an artist with that name."
      render :index
    end
  end

  def search_youtube
    band = params[:band]

    search_params = params[:concert].split(', ')

    @songs = params[:songs]
    @band = band
    @date = search_params[0]
    @tour = search_params[1]
    @venue = search_params[2]
    @city = search_params[3]
    @state = search_params[4]

    date, tour, venue, city, state = search_params
    puts "#{date}, #{tour}, #{venue}, #{city}, #{state}"
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

    p @title_id
    render :search_youtube
  end

  def make_concert

  end
end
