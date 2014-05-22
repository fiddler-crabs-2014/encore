class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.date :date, null: false
      t.belongs_to :venue, null: false, index: true

      t.timestamps
    end
  end
end
