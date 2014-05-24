class CreateConcertSongs < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.belongs_to :song, index: true
      t.belongs_to :concert, index: true
      t.string :video_identifier, null: false

      t.timestamps
    end
  end
end
