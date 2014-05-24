class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, null: false
      t.string :city, null: false
      t.string :state, null: false

      t.timestamps
    end
  end
end
