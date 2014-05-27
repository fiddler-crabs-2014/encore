require 'net/http'
class Setlist

  def initialize(mbid)
    @mbid = mbid
    @setlists = JSON.parse(Net::HTTP.get_response(
                URI.parse("http://api.setlist.fm/rest/0.1/artist/#{@mbid}/setlists.json")
               ).body)
  end

  def search
    set_songs = @setlists["setlists"]["setlist"].map do |set|
      if set["sets"].empty?
        [nil]
      elsif set["sets"]["set"].is_a? Array
        nested_array_sets(set)
      elsif set["sets"]["set"]["song"].is_a? Hash
        one_song_in_nested_set(set)
      else
        normal_sets(set)
      end
    end

    return concerts_with_sets(set_songs)
  end

  private

    def concerts_with_sets(set_songs)
      concerts = @setlists["setlists"]["setlist"].map do |concert|
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

      concerts_and_sets = Hash[concerts.zip(set_songs)].each_value do |value|
        value.flatten! unless value.is_a? String
      end

      return concerts_and_sets
    end

    # Concerts with multiple sets are handled as arrays
    # To keep this working with zipping up the concerts, we need to save each set as its own array
    # within one array
    def nested_array_sets(set)
      Array.new(
        set["sets"]["set"].map do |set|
          # If there are multiple songs, they'll be nested in an array
          if set["song"].is_a? Array
            multiple_songs_in_set(set["song"])
          # If there's just one song, such as a song in an encore set, it's a hash
          elsif set["song"].is_a? Hash
            one_song_in_set_hash(set["song"])
          end
        end
      )
    end

    def multiple_songs_in_set(set)
      set.map do |song|
        song["@name"]
      end
    end

    def one_song_in_set_hash(song)
      song["@name"]
    end

    # For one song sets
    def one_song_in_nested_set(set)
      if set["sets"]["set"]["song"]["@name"].nil?
        set["@name"]
      else
        set["sets"]["set"]["song"]["@name"]
      end
    end

    # For straightforward sets
    def normal_sets(set)
      set["sets"]["set"]["song"].map { |song| song["@name"] }
    end

end
