class CreatePlaylist

  def initialize(concert = nil)
    @concert = concert
    configure_client
  end

  def make_playlist
    @client.add_playlist(:title => @concert, :description => @concert)
  end

  def add_video(playlist_id, video)
    @client.add_video_to_playlist(playlist_id, video)
  end

  private 

    def configure_client
      @client = YouTubeIt::Client.new(
                :username => "raderj89",
                :password =>  "jaipur7786",
                :dev_key => ENV['YOUTUBE_DEVELOPER_KEY'])
    end
end