class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video_identifier, null: false
      t.belongs_to :song, index: true

      t.timestamps
    end
  end
end
