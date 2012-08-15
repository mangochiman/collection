class Song < ActiveRecord::Base
	belongs_to :music_album
	
	def upload_music(song)
		self.binary_music = song.read
		self.name = song.original_filename
		self.content_type = song.content_type.chomp
	end
end
