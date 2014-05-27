class SearchesController < ApplicationController

  def index
  end

  def search
    band_query = params[:band]
    @band = Artist.where(name: band_query).first_or_initialize
    mb_result = @band.mbid || Musicbrainz.search(@band.name)

    if mb_result
      @results = Setlistfm.new(mb_result, params[:page]).search
      save_band(mb_result) if @band.id.nil?
    else
      flash[:warning] = "Sorry - we couldn't find an artist with that name."
      render :index
    end
  end

  def search_youtube
    @band = Artist.find_by(name: params[:band])
    search_params = params[:concert].split(', ')
    save_concert(params)

    search1 = "#{@band.name}, #{@venue.name}, #{@venue.state}, #{@date}"
    search2 = "#{@band.name}, #{@venue.name}, #{@date}"
    search3 = "#{@band.name}, #{@venue.state}, #{@date}"
    # A couple more search options
    # search4 = "#{@band.name}, #{@tour}, #{@date}"
    # search5 = "#{@band.name}, #{@tour}, #{@venue.name}"

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
      end
    end
  end

  private
    def save_band(result)
      @band.mbid = result
      @band.save!
    end

    def save_concert(params)
      puts "PARAMS"
      p params
      puts "\n\nSONGS?"
      p @songs = params[:songs].split(', ')
      puts "AfTER\n\n"
      @concert_info = params[:concert].split(', ')
      @venue = Venue.where(name: @concert_info[2] || "n/a", city: @concert_info[3] || "n/a", state: @concert_info[4] || "n/a").first_or_create
      @concert = Concert.where(date: @concert_info[0], venue_id: @venue.id).first_or_create
      @concert_artist = ConcertArtist.where(concert_id: @concert.id, artist_id: @band.id).first_or_create
      @date = @concert.date.strftime('%B %e %Y')
      @tour = @concert_info[1]
      @songs.each_with_index do |song_name, i|
        next if song_name.nil?
        song = Song.where(title: song_name, artist_id: @band.id).first_or_create
        ConcertSong.where(concert_id: @concert.id, song_id: song.id, order: i).first_or_create
      end
    end
end
