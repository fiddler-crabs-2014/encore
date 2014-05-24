class PagesController < ApplicationController
  def index
  end

  def search
      band_name = params[:band]
      mbid = Musicbrainz.search(band_name)
      @results = Setlist.search(band_name, mbid)
<<<<<<< HEAD

    else
      flash.now[:error] = "Please actually type something in the search field. We can't raise this baby alone."
      render :index
    end
=======
      @results[1].each { |result| result[1].flatten! }
>>>>>>> a61013c0bab0fde01dc3dd8dc73d2eda31a78674
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

    p "================"
    @date = search_params[0]
    # p @tour = Tour.find_by_venue("search_params[2]") || Tour.create(
    @venue = search_params[2]
    @city = search_params[3]
    @state = search_params[4]

    p @songs
    p "================"


    date, tour, venue, city, state = search_params
    puts "#{date}, #{tour}, #{venue}, #{city}, #{state}"
    search1 = "#{band}, #{venue}, #{state}, #{date}"
    search2 = "#{band}, #{venue}, #{date}"
    search3 = "#{band}, #{state}, #{date}"

    # @band = Band.create(params[:band])
    # venue = Venue.create(params[:venue])

    # @concert = @user.concerts.build(params[:concert].merge(band_id: @band.id, venue_id: venue.id))

    @titles_ids = {}

    results = []

    # if @concert.save
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



    p @titles_ids
    render :search_youtube
  end

  def make_concert

  end
end
