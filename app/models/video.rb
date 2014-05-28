class Video < ActiveRecord::Base

  after_update :send_flag_email

  validates :identifier, presence: true
  validates :concert_song_id, presence: true

  belongs_to :concert_song

  private

    def send_flag_email
      if self.correct == false
        FlaggedVideoMailer.video_flagged(self.concert_song.concert, self).deliver
      end
    end
end
