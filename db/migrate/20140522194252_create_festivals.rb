class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
