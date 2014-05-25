class CreateConcertArtists < ActiveRecord::Migration
  def change
    create_table :concert_artists do |t|
      t.belongs_to :concert, index: true
      t.belongs_to :artist, index: true

      t.timestamps
    end
  end
end
