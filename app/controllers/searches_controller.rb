require 'json'

class SearchesController < ApplicationController

  def index
  end

  def search
    band_query = params[:band]
    @band = Artist.where(name: band_query).first_or_initialize
    mb_result = @band.mbid || Musicbrainz.search(@band.name)

    if mb_result
      save_band(mb_result) if @band.id.nil?
      @results = Setlistfm.search(mb_result)

      @results.each do |concert, songs|
        concert_info = concert.split(', ')
        venue = Venue.where(name: concert_info[2], city: concert_info[3], state: concert_info[4]).first_or_create
        concert = Concert.where(date: concert_info[0], venue_id: venue.id).first_or_create
        concert_artist = ConcertArtist.where(concert_id: concert.id, artist_id: @band.id).first_or_create
        date = concert.date.strftime('%B %e %Y')
        tour = concert_info[1]

        songs.each_with_index do |song_name, i|
          song = Song.where(title: song_name, artist_id: @band.id).first_or_create
          ConcertSong.where(concert_id: concert.id, song_id: song.id, order: i).first_or_create
        end
      end
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
    # puts "\n\n\nHERE ARE THE SONGS"
    @songs = params[:songs]
    # Setlist.where(data: params[:songs].to_json, concert_id: @concert.id).first_or_create.
    # puts "AFTER\n\n\n"

    @date = @concert.date.strftime('%B %e %Y')
    @tour = search_params[1]

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
end
