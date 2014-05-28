class ConcertSong < ActiveRecord::Base
  validates :concert_id, presence: true
  validates :song_id, presence: true

  belongs_to :concert
  belongs_to :song

  has_many :videos

end
