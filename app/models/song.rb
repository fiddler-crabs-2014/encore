class Song < ActiveRecord::Base
  belongs_to :artist

  has_many :concert_songs
  has_many :concerts, through: :concert_songs
end
