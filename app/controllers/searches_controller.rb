class SearchesController < ApplicationController

  def index
  end

  def search
    band_query = params[:band]
    @band = Artist.find_or_initialize_by(name: band_query)
    mb_result = @band.mbid || Musicbrainz.search(@band.name)

    returned_setlists = JSON.parse(Net::HTTP.get_response(
                URI.parse("http://api.setlist.fm/rest/0.1/artist/#{mb_result}/setlists.json")
               ).body)
    setlists_returned = returned_setlists["setlists"]["@total"]
    @max_pages = (setlists_returned.to_i / 20) + 1

    if mb_result
      @results = Setlistfm.new(mb_result, params[:page]).search
      save_band(@band, mb_result) if @band.id.nil?
    else
      flash[:warning] = "Sorry - we couldn't find an artist with that name."
      render :index
    end
  end

  def search_youtube
    @band = Artist.find_by_name(params[:band])
    search_params = params[:concert].split(', ')

    #===============================================
    #search if the concert already exists
    search_date = search_params[0]

    #If the venue doesn't exist, there has never been a show there
    #therefore go right to making the concert
    venue = Venue.find_by(name: search_params[2])

    unless venue.nil?

      #if the venue does exist, search for a concert that took place at that venue
      #on this specific date
      @concerts = Concert.where(venue_id: venue.id, date: search_date)

      matched_concert_ids = @concerts.map{ |concert| concert.id }

      #to account for festivals go through every possible artist that played
      #that venue on that specific day
      matched_concert_ids.each do |concertID|
        unless ConcertArtist.where(concert_id: concertID, artist_id: @band.id).empty?
          @concert = Concert.find(concertID)
        end
      end

      if @concert

        redirect_to @concert

      end

    else

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
  end

  private
    def save_band(band, result)
      band.mbid = result
      band.save!
    end

    def save_concert(params)
      @songs = params[:songs]
      @concert_info = params[:concert].split(', ')
      if @concert_info.size > 4
        @venue = Venue.find_or_create_by(name: @concert_info[2] || "n/a", city: @concert_info[3] || "n/a", state: @concert_info[4] || "n/a")
        @concert = Concert.find_or_create_by(date: @concert_info[0], venue_id: @venue.id)
        @concert_artist = ConcertArtist.find_or_create_by(concert_id: @concert.id, artist_id: @band.id)
        @date = @concert.date.strftime('%B %e %Y')
        @tour = @concert_info[1]
      else
        @venue = Venue.find_or_create_by(name: @concert_info[1] || "n/a", city: @concert_info[2] || "n/a", state: @concert_info[3] || "n/a")
        @concert = Concert.find_or_create_by(date: @concert_info[0], venue_id: @venue.id)
        @concert_artist = ConcertArtist.find_or_create_by(concert_id: @concert.id, artist_id: @band.id)
        @date = @concert.date.strftime('%B %e %Y')
      end
      
      @playlist = CreatePlaylist.new("#{@band.name} live at #{@venue.name}, #{@venue.city}, #{@venue.state}, #{@concert.date.strftime('%B %e, %Y')}")
      @playlist_id = @playlist.make_playlist.playlist_id
      @concert.update(yt_playlist: @playlist_id)

      if @songs.is_a? Array
        @songs.each_with_index do |song_name, i|
          next if song_name.nil?
          song = Song.find_or_create_by(title: song_name, artist_id: @band.id)
          ConcertSong.find_or_create_by(concert_id: @concert.id, song_id: song.id, order: i)
        end
      elsif @songs.is_a? String
        @songs = [@songs]
        song = Song.find_or_create_by(title: @songs, artist_id: @band.id)
        ConcertSong.find_or_create_by(concert_id: @concert.id, song_id: song.id, order: 1)
      end

    end
end
