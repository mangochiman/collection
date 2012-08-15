class Photo < ActiveRecord::Base
	belongs_to :photo_album
	has_one :thumbnail, :dependent => :destroy
	#validates_format_of:content_type, :with => /^image/, :message => "::Only images are suported"
	
	def upload_file(file)
		self.filename = file.original_filename
		self.content_type = file.content_type.chomp
		self.binary_data = file.read
	end
end
