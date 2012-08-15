require 'fastercsv'
class OwnersController < ApplicationController

	def new
		@owner = Owner.new
	end
	
	def create
		@owner = Owner.create(params[:owner])
		if @owner.save
			flash[:notice] = "You can now create  your own photo and music albums for free"
			$owner_id = @owner.id
			redirect_to :controller => "photo_albums",:action => "new", :id => @owner
		else
			flash[:notice] = "There was an error when saving your details"
			render:action => "new"
		end
	end
	
	def edit
		@owner = Owner.find(params[:id])
	end
	
	def update
		@owner = Owner.find(params[:id])
		if @owner.update_attributes(params[:owner])
			flash[:notice] = "You have successfully updated the details"
		else
			flash[:notice] = "There was an error when updating your details"
		end
	end
	
	def display_all
		@owners = Owner.all
	end
=begin	
	def test
	raise params.inspect
		if params[:screen_name][:id]
			session[:owner_id] = params[:screen_name][:id]
			if params[:album] == "photo_album"
				session[:abum_type] = params[:album]
				redirect_to :controller => "photos", :action => "upload" and return
			elsif params[:album] == "music_album"
				flash[:notice] = "We are still working. Sorry for the inconvenience"
				redirect_to :action => "display_all"
			elsif params[:album] == "books"
				flash[:notice] = "We are still working. Sorry for the inconvenience"
				redirect_to :action => "display_all"
			end
		end
	end
=end
	
	def getcsv
      entries = Owner.find(:all)
      csv_string = FasterCSV.generate(:col_sep => "\t",:row_sep => "\n") do |csv| 
            csv << ["ID","FirstName","ScreenName","LastName"]
            entries.each do |e|
              csv << [e.id, e.first_name, e.screen_name, e.last_name]
            end
          end
          send_data csv_string, :type => "text/plain", 
           :filename=>"entries.csv",
           :disposition => 'attachment'
	end

end
