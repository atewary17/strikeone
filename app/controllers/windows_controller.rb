class WindowsController < ApplicationController
	
	def index
	end

	def upload_image
	end

	def image_upload
		@personnel=Personnel.find(1)
		puts "..........................."
		puts @personnel.name
			if params[:images]
		        params[:images].each { |image|
		        @personnel.images.create(scan: image)
		        }
		    end
		redirect_to :back
	end

	def search_document
	end

	def upload_register
		if params.select{|key, value| value == ">" }.keys[0] != nil
			redirect_to :controller => 'windows', :action => 'process_image', :image_id => params.select{|key, value| value == ">" }.keys[0]
		else
			@images = Image.all
		end
	end

	def process_image
		link=params[:image_id]
		picked_image = Image.find(link)
		
		require "google/cloud/vision"
		Google::Cloud::Vision.configure do |config|
		  config.project_id  = "lottery-220502"
		  config.credentials = File.join(Rails.root, 'lottery-c12cc4ecd43a.json')
		end

		vision = Google::Cloud::Vision.new
		image = vision.image "https:"+picked_image.scan.url
		document = image.document
		@text=document.text
		@label=image.labels
		# puts "....................."
		# puts @label
		
		web = image.web

		@web_entities=web.entities

	end

end
