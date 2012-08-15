class PhotoAlbum < ActiveRecord::Base
	has_many :photos, :dependent => :destroy
	belongs_to :owner
	
end
