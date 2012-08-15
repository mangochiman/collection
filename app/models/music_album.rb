class MusicAlbum < ActiveRecord::Base
	has_many :songs, :dependent => :destroy
	belongs_to :owner
end
