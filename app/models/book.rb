class Book < ActiveRecord::Base
	belongs_to:book_collection
	
	def upload_book(book)
		self.name = book.original_filename
		self.content_type = book.content_type.chomp
		self.binary_book = book.read
	end
end
