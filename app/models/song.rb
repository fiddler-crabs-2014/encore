class Song < ActiveRecord::Base
  validates :artist_id, presence: true

  belongs_to :artist
  has_many :videos

  has_many :concert_songs
  has_many :concers, through: :concert_songs
end
