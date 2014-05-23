require 'google/api_client'

class Youtube
  def self.search(arg)
    client, youtube = configure_client

    begin
      # Call the search.list method to retrieve results matching the specified
      # query term.
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => arg,
          :maxResults => 25
        }
      )

      videos = []
      # channels = []
      # playlists = []

      # Add each result to the appropriate list, and then display the lists of
      # matching videos, channels, and playlists.
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            videos << "#{search_result.snippet.title} (#{search_result.id.videoId})"
          # when 'youtube#channel'
          #   channels << "#{search_result.snippet.title} (#{search_result.id.channelId})"
          # when 'youtube#playlist'
          #   playlists << "#{search_result.snippet.title} (#{search_result.id.playlistId})"
        end
      end

      return videos

      # puts "Channels:\n", channels, "\n"
      # puts "Playlists:\n", playlists, "\n"
    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end
  end

  private

    def self.configure_client
      client = Google::APIClient.new(
        :key => ENV['YOUTUBE_DEVELOPER_KEY'],
        :authorization => nil,
        :application_name => ENV['PROGRAM_NAME'],
        :application_version => '1.0.0'
      )

      youtube = client.discovered_api(ENV['YOUTUBE_API_SERVICE_NAME'], ENV['YOUTUBE_API_VERSION'])

      return client, youtube
    end
end
