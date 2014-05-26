require 'net/http'
class Setlistfm

  def self.search(mbid)
    setlists = JSON.parse(Net::HTTP.get_response(URI.parse("http://api.setlist.fm/rest/0.1/artist/#{mbid}/setlists.json")).body)

    set_songs = []
    setlists["setlists"]["setlist"].each do |set|
      # If no songs are in the setlist, just add an array of nil
      if set["sets"].empty?
        set_songs << [nil]
      # Concerts with multiple sets are handled as arrays
      # To keep this working with zipping up the concerts, we need to save each set as its own array
      # within one array
      elsif set["sets"]["set"].is_a? Array
        set_songs << Array.new(
          set["sets"]["set"].map do |set|
            # If there are multiple songs, they'll be nested in an array
            if set["song"].is_a? Array
              set["song"].map do |song|
                song["@name"]
              end
            # If there's just one song, such as a song in an encore set, it's a hash
            elsif set["song"].is_a? Hash
              set["song"]["@name"]
            end
          end
        )
      elsif set["sets"]["set"]["song"].is_a? Hash
        # For one song sets
        if set["sets"]["set"]["song"]["@name"].nil?
          set_songs << set["@name"]
        else
          set_songs << set["sets"]["set"]["song"]["@name"]
        end
      else
        # For straightforward sets
        set_songs << set["sets"]["set"]["song"].map { |song| song["@name"] }
      end
    end

    concerts = setlists["setlists"]["setlist"].map do |concert|
      if concert["@tour"].nil? || concert["@tour"].empty?
        "#{Date.parse(concert["@eventDate"]).strftime('%B %e %Y')}, " +
        "#{concert["venue"]["@name"]}, #{concert["venue"]["city"]["@name"]}, " +
        "#{concert["venue"]["city"]["@state"]}"
      else
        "#{Date.parse(concert["@eventDate"]).strftime('%B %e %Y')}, " +
        "#{concert["@tour"]}, #{concert["venue"]["@name"]}, " +
        "#{concert["venue"]["city"]["@name"]}, #{concert["venue"]["city"]["@state"]}"
      end
    end

    concerts_songs = concerts.zip(set_songs)

    concerts_with_sets = {}

    concerts_songs.each do |concert, songs|
      concerts_with_sets[concert] = songs.flatten unless songs.is_a? String
    end

    return concerts_with_sets
  end

end
