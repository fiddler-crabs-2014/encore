class Concert < ActiveRecord::Base
  validates :date, presence: true
  validates :venue_id, presence: true

  belongs_to :venue

  has_many :concert_artists
  has_many :artists, through: :concert_artists

  has_many :concert_songs
  has_many :songs, through: :concert_songs

  has_many :attended_concerts
  has_many :users, through: :attended_concerts

  has_many :setlists

end
