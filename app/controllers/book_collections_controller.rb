class BookCollectionsController < ApplicationController

	def new
		@book_collection = BookCollection.new
	end
	
	def create
		@book_collection = BookCollection.new(params[:book_collection])
		@book_collection.owner_id = session[:owner_id]
		if @book_collection.save
			flash[:notice] = "Your Book Collection has been saved"
			redirect_to :controller => "books", :action => "available_book_options"
		else
			flash[:notice] = "Error while saving. Please try again"
			render:action => "new"
		end
	end
	
	def missed_book_collection
		@book_collection = BookCollection.new
		
	end
	
	def create_missed
		@book_collection = BookCollection.create(params[:book_collection])
		@book_collection.name = session[:owner_id]
		if @book_collection.save
			flash[:notice] = "Your Book Collection has been saved"
		else
			flash[:notice] = "Error while saving. Please try again"
		end
	end
	
	def rename
		@book_collection = BookCollection.find(params[:id])
	end
	
	def update
		@book_collection = BookCollection.find(params[:id])
		if @book_collection.update_attributes(params[:book_collection])
			flash[:notice] = "You have successfully renamed your book collection"
		else
			flash[:notice] = "Error while renaming. Please try again"
		end
	end
	
	def delete
		@book_collection = BookCollection.find(params[:id])
		if @book_collection.delete
			flash[:notice] = "You have successfully deleted your item"
		else
			flash[:notice] = "Error while deleting the item."
		end
	end
end
