class ConcertArtist < ActiveRecord::Base
  belongs_to :concert
  belongs_to :artist

  validates_uniqueness_of :concert_id, :scope => :artist_id
end
