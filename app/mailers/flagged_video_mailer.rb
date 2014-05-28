class FlaggedVideoMailer < ActionMailer::Base
  default from: "admin@encore.com"

  def video_flagged(concert, video)
    @concert = concert
    @video = video

    headers["References"] = "<concerts/#{@concert.id}@encore.com>"

    mail(to: 'raderj89@gmail.com', subject: "Video flagged for Concert #{concert.id} - Song: #{@video.concert_song.song.title }")
  end
end
