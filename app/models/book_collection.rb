class BookCollection < ActiveRecord::Base
	has_many:books, :dependent => :destroy
	belongs_to :owner
end
