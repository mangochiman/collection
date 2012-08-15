class CreateMusicAlbums < ActiveRecord::Migration
  def self.up
    create_table :music_albums do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :music_albums
  end
end
