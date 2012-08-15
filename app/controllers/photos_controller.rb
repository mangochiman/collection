require 'rubygems'
require 'RMagick'
class PhotosController < ApplicationController
	def upload
	
		@photo = Photo.new
		@owner = Owner.first(:conditions => {:id => session[:owner_id]}) 
		if @owner.photo_albums == []
			flash[:notice] = "#{@owner.screen_name} has no photo albums yet. create one first to add photos"
			session[:id] = Owner.first(:conditions => {:id => session[:owner_id]}).id
			redirect_to :controller => "photo_albums",:action => "missed_photo_albums_new" and return
		else
			session[:photo_album_id] = @owner.photo_albums.collect{|album|album.id}.first.to_i
		end
		@total_photos = @owner.photo_albums.collect{|photo|photo.photos.count}
		
	end
	
	def save_photo
		@photo = Photo.new
		@photo.upload_file(params[:photo])
		@photo.update_attribute(:photo_album_id,session[:photo_album_id])
		if @photo.save
			@thumb = Thumbnail.new
			@photo = Photo.last
			@image=Magick::ImageList.new
			image = @image.from_blob(@photo.binary_data)
			thumbnail = image.crop_resized!(88,88)
			@thumb.photo_id = @photo.id
			@thumb.image = thumbnail.to_blob
			@thumb.save
			flash[:notice] = "You have successfully uploaded your photo"
			redirect_to :action => "upload"
		else
			flash[:notice] = "Unable to save image. There was an error when saving your image"
			render:action => "upload"
		end
	end
	
	def view_photos
	end
	
	def manage_photos
		@owner = Owner.first(:conditions => {:id => session[:owner_id]})
		@photo_album = PhotoAlbum.first(:conditions => {:owner_id => @owner})
		@unhidden_photos = Photo.all(:conditions => {:photo_album_id => @photo_album,:hidden => nil})
		@hidden_photos = Photo.all(:conditions => {:photo_album_id => @photo_album,:hidden => true})
		#session[:hidden_photos] = Photo.all(:conditions => {:photo_album_id => @photo_album,:hidden => true})
	end
	
	def view_album_photos
		@owner = Owner.first(:conditions => {:id => session[:owner_id]})
		@photo_album = PhotoAlbum.first(:conditions => {:owner_id => @owner})
		@photos = Photo.all(:conditions => {:photo_album_id => @photo_album})
		#@photos = Photo.all(:conditions => ["id >=90"])
	end
	
	
	def available_photo_options
		session[:owner_id] = params[:screen_name][:id]
		if params[:album] == "photo_album"
			session[:abum_type] = params[:album]
		elsif params[:album] == "music_album"
			flash[:notice] = "We are still working. Sorry for the inconvenience"
			redirect_to :controller => "songs",:action => "select_music_options"
		elsif params[:album] == "books"
			flash[:notice] = "We are still working. Sorry for the inconvenience"
			redirect_to :controller => "books", :action => "available_book_options"
		end
	end
	
	def test_photo_options
		
			#session[:abum_type] = params[:album]
			if params[:options] == "upload photos"
				redirect_to :action => "upload" and return
			elsif params[:options] == "view photos"
				redirect_to :action => "view_album_photos" and return
			elsif params[:options] == "manage photos"
				redirect_to :action => "manage_photos"
			end
		
	end
	
	def image
		@photo = Photo.find(params[:id])
		send_data @photo.binary_data, :type => @photo.content_type,:disposition => "inline"
	end
	
	def remove_photo
		@photo = Photo.find(params[:id])
		if @photo.delete
			flash[:notice] = "You have successfully deleted your picture"
			redirect_to :action => "manage_photos"
		else
			flash[:notice] = "Operation of deleting was not successful. Try again"
			render :action => "manage_photos"
		end
	end
	
	
	def hide_picture
		@picture = Photo.find(params[:id])
		if @picture.update_attribute(:hidden, true)
		flash[:notice] = "You have successfully hidden #{@picture.filename}"
		redirect_to :action => "manage_photos"
		end
	end
	
	def show_hidden
		@owner = Owner.first(:conditions => {:id => session[:owner_id]})
		@photo_album = PhotoAlbum.first(:conditions => {:owner_id => @owner})
		@hidden_photos = Photo.all(:conditions => {:photo_album_id => @photo_album,:hidden => true}) 
	end
	
	def activate_hidden_picture
		@picture = Photo.find(params[:id])
		if @picture.update_attribute(:hidden, nil)
			flash[:notice] = "The picture has been restored"
			redirect_to :action => "show_hidden"
		end
	end
	
	def share_picture
	end
	
end
