class CreateAttendedConcerts < ActiveRecord::Migration
  def change
    create_table :attended_concerts do |t|
      t.belongs_to :concert, index: true
      # t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
