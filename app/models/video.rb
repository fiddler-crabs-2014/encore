class Video < ActiveRecord::Base
  validates :identifier, presence: true
  validates :concert_song_id, presence: true

  belongs_to :concert_song
end
