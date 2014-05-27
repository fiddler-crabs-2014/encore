class CreateConcertPhotos < ActiveRecord::Migration
  def change
    create_table :concert_photos do |t|
      t.references :user, index: true
      t.references :concert, index: true
      t.string :image, null: false

      t.timestamps
    end
  end
end
