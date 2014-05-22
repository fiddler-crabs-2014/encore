class CreateFestivalDates < ActiveRecord::Migration
  def change
    create_table :festival_dates do |t|
      t.date :date, null: false
      t.belongs_to :festival, index: true

      t.timestamps
    end
  end
end
