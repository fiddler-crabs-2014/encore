class AddPlaylistIdToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :yt_playlist, :string
  end
end
