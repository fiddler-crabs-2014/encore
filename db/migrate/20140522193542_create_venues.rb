class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, default: "n/a"
      t.string :city, default: "n/a"
      t.string :state, default: "n/a"

      t.timestamps
    end
  end
end
