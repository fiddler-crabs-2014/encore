class ConcertSong < ActiveRecord::Base
  validates :concert_id, presence: true
  validates :song_id, presence: true
  validates :video_identifier, presence: true

  belongs_to :concert
  belongs_to :song

  validates_uniqueness_of :video_identifier, scope: :concert_id
end
