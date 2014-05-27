class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :identifier
      t.belongs_to :concert_song, index: true

      t.timestamps
    end
  end
end
