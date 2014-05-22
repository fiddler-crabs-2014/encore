class ConcertArtist < ActiveRecord::Base
  belongs_to :concert
  belongs_to :artist
end
