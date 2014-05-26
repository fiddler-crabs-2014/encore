class ConcertArtist < ActiveRecord::Base
  validates :concert_id, presence: true
  validates :artist_id, presence: true

  belongs_to :concert
  belongs_to :artist

  validates_uniqueness_of :concert_id, scope: :artist_id
end
