class SongsController < ApplicationController

	def new_upload
		@song = Song.new
	end
	
	def view_music_files
		music_album = MusicAlbum.first(:conditions => {:owner_id => session[:owner_id]})
		@songs = Song.all(:conditions => {:music_album_id => music_album })
	end
	
	def manage_music_files
		music_album = MusicAlbum.first(:conditions => {:owner_id => session[:owner_id]})
		@songs = Song.all(:conditions => {:music_album_id => music_album })
	end
	
	def upload
		@music_album = MusicAlbum.find(:first,:conditions => {:owner_id => session[:owner_id]})
		@music_album_id = @music_album.id
		@song = Song.new
		@song.upload_music(params[:song])
		@song.music_album_id = @music_album_id
		if @song.save
			flash[:notice] = "You have successfully saved song"
			redirect_to :action => "new_upload"
		else
			flash[:notice] = "Failed to save your file. Please you may wish to retry"
			render:action => "new_upload"
		end
	end
	
	def select_music_options
	end
	
	def manage_music_options
	end
	
	def select_manage_option
		option = params[:options]
		if option == "Rename Song"
			redirect_to :action => "rename_song_list"
		#elsif option == "Delete Song"
		else
			redirect_to :action =>"delete_song_list"
		end
	end
	
	def rename_song_list
		album = MusicAlbum.first(:conditions => {:owner_id => session[:owner_id]})
		@songs = Song.all(:conditions => {:music_album_id => album.id})
	end
	
	def delete_song_list
		album = MusicAlbum.first(:conditions => {:owner_id => session[:owner_id]})
		@songs = Song.all(:conditions => {:music_album_id => album.id})
	end
	
	def delete_songs
		songs = params[:song][:id]
		songs.each do |song|
			x = Song.find(song)
			x.delete
		end
		flash[:notice] = "You have successfully deleted songs"
		redirect_to :action => "delete_song_list"
	end
	
	def rename_song
		song = params[:song][:id]
		@song = Song.find(song)
	end
	
	def rename
		song = Song.find(params[:id])
		if song.update_attributes(params[:song])
			flash[:notice] = "You have successfully renamed song"
			redirect_to :action => "rename_song_list"
		else
			flash[:notice] = "Error while renaming song. Try again"
			render:action => "rename"
		end
	end
	
	def select_option
		selection = params[:options]
		if selection == "Upload Music"
			redirect_to :action => "new_upload" and return
		elsif selection == "View Music" 
			redirect_to :action => "view_music_files" and return
		elsif selection == "Manage Music"
			redirect_to :action => "manage_music_options" and return
		end
	end
	
	def selected_song
		flash[:notice] = "We are still working. Sorry for any inconvenience caused"
		redirect_to :action => "view_music_files"
	end
end
