class Owner < ActiveRecord::Base
	has_many :music_albums, :dependent => :destroy
	has_many :photo_albums, :dependent => :destroy
	has_many :book_collections, :dependent => :destroy
end
