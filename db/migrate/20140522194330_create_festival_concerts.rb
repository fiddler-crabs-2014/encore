class CreateFestivalConcerts < ActiveRecord::Migration
  def change
    create_table :festival_concerts do |t|
      t.belongs_to :festival_date, index: true
      t.belongs_to :concert, index: true

      t.timestamps
    end
  end
end
