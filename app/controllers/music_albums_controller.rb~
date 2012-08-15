class MusicAlbumsController < ApplicationController

	def new
		@music_abum = MusicAlbum.new
	end
	
	def create
		@music_album = MusicAlbum.new(params[:music_album])
		@music_album.owner_id = session[:owner_id]
		if @music_album.save
			flash[:notice] = "Your Music Album has been created successfully"
			redirect_to :controller =>"book_collections",:action =>"new"
		else
			flash[:notice] = "You have not successfully created. Please retry!!"
			render:action => "new"
		end
	end
	
	def edit
		@music_album = MusicAlbum.find(params[:id])
	end
	
	def update
		@music_album = MusicAlbum.find(params[:id])
		if @music_album.update_attributes(params[:music_album])
			flash[:notice] = "You have successfylly updated the name of your album"
		else
			flash[:notice] = "Renaming of your music album was not successful"
		end
	end
end
