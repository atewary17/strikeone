class WindowsController < ApplicationController
	before_filter :search_index
	
	def index
	end

	def upload_image
	end

	def image_upload
		@personnel=current_personnel
		if params[:images]
	        params[:images].each { |image|
	        @personnel.images.create(scan: image)
	        }
	    end
		redirect_to :back
	end

	def search_index
		if params[:label_description]
			label_description = params[:label_description]
			@labels=Label.where(:description => label_description)
			@web_entities=WebEntity.where(:description => label_description)
			@combined_web_elements = []
			@labels.each do |label|
				@combined_web_elements += [[label.image, label.description, label.score]]
			end
			@web_entities.each do |web_entity|
				@combined_web_elements += [[web_entity.image, web_entity.description, web_entity.score]]				
			end
			@combined_web_elements=@combined_web_elements.sort_by{|elem| elem[2]}.reverse!
		else
		end
	end

	# def search
	#   	  @search = Label.search(params[:q])
	#   	  @label = @search.result
	# 	if params[:q].blank?
	#     	@labels = Label.all
	#   	end
 #  	end

	def upload_register
		if params.select{|key, value| value == ">" }.keys[0] != nil
			redirect_to :controller => 'windows', :action => 'processed_images', :image_id => params.select{|key, value| value == ">" }.keys[0]
		else
			@images = Image.all
		end
	end

	def processed_images
		link=params[:image_id]
		@picked_image = Image.find(link)
	end

	def unprocessed_uploads
		@images = Image.where(processed: nil)
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
		@label.each do |label|
			label_instance = Label.new
			label_instance.description = label.description
			label_instance.score = label.score
			label_instance.image_id = link.to_i
			label_instance.identification_code = label.mid
			label_instance.save
		end
		
		web = image.web
		@web_entities=web.entities
		@web_entities.each do |web_entity|
			web_entity_instance = WebEntity.new
			web_entity_instance.description = web_entity.description
			web_entity_instance.score = web_entity.score
			web_entity_instance.image_id = link.to_i
			web_entity_instance.identification_code = web_entity.entity_id
			web_entity_instance.save
		end
	end

	def autocomplete_web_entities
	  label_description = params[:term]
	  label_description=label_description.gsub(/\(/, '')
	  label_description=label_description.gsub(/\)/, '')
	  label_description=label_description.gsub(/\&/, '')  
	  label_description=label_description.gsub(/\s+$/, '')
	  label_description=label_description.gsub(/\:/, '')
	  label_description=(label_description.gsub(/\s+/, '&'))+":*"
	  labels = WebEntity.all.where("to_tsvector(description) @@ to_tsquery(:q)", q: label_description)
	  render :json => labels.map { |label| {:id => label.id, :label => label.description , :value => label.description } }
	end
end
