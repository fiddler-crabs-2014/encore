class Concert < ActiveRecord::Base
  belongs_to :venue

  has_many :concert_artists
  has_many :artists, through: :concert_artists

  has_many :concert_songs
  #has_many :concerts, through: :concert_songs

  # has_many :attended_concerts
  # has_many :users, through: :attended_concerts

  #double check!!
  #=============================

end
