class ConcertSong < ActiveRecord::Base
  belongs_to :concert
  belongs_to :song

  validates_uniqueness_of :video_identifier, :scope => :concert_id
end
