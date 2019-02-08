class WindowsController < ApplicationController
	def index
	end

	def upload_image
	end

	def image_upload
		@personnel=Personnel.find(1)
			if params[:images]
		        params[:images].each { |image|
		        @personnel.images.create(scan: image)
		        }
		    end
		redirect_to :back
	end

	def search_document
	end

end
