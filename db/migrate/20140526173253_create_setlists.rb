class CreateSetlists < ActiveRecord::Migration
  def change
    create_table :setlists do |t|
      t.text :data
      t.belongs_to :concert, index: true

      t.timestamps
    end
  end
end
