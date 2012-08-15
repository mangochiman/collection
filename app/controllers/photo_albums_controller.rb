class PhotoAlbumsController < ApplicationController
	
	def new
		@photo_album = PhotoAlbum.new
	end
	
	def create
		@photo_album = PhotoAlbum.create(params[:photo_album])
		if @photo_album.save
			flash[:notice] = "You have successfully created your photo album"
			redirect_to :controller => "music_albums", :action => "new", :id => @photo_album.id
		else
			flash[:notice] = "You have not created the photo album. Please try again"
			render:action => "new"
		end
	end 
	
	def edit
		@photo_album = PhotoAlbum.find(params[:id])
	end
	
	def update
		@photo_album = PhotoAlbum.find(params[:id])
		if @photo_album.update_attributes(params[:id])
			flash[:notice] = "You have successfully renamed your photo album"
		else
			flash[:notice] = "Renaming of your photo album was not successfull. Retry"
			render:action => "edit"
		end
	end
	
	def missed_photo_albums_new
		@photo_album = PhotoAlbum.new
	end
	
	def missed_photo_albums_create
		@photo_album = PhotoAlbum.create(params[:photo_album])
		if @photo_album.save
			flash[:notice] = "You have now successfully created new photo album"
			redirect_to :controller => "photos", :action => "upload"
		else
			flash[:notice] = "You have not created the photo album. Please try again"
			render:action => "missed_photo_albums_create"
		end
	end 
	
end
