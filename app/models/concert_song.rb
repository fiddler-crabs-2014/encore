class ConcertSong < ActiveRecord::Base
  belongs_to :concert
  belongs_to :song

  validates_uniqueness_of :concert_id, :scope => :song_id
end
