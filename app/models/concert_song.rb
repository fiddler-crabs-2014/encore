class ConcertSong < ActiveRecord::Base
  belongs_to :concert
  belongs_to :song
end
