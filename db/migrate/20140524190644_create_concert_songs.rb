class CreateConcertSongs < ActiveRecord::Migration
  def change
    create_table :concert_songs do |t|
      t.string :video_identifier, null: false
      t.belongs_to :concert, index: true
      t.belongs_to :song, index: true

      t.timestamps
    end
  end
end
