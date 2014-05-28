class AddCorrectToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :correct, :boolean, default: true
  end
end
