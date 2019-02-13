require 'rufus-scheduler'

scheduler = Rufus::Scheduler . new
scheduler.every '1m' do
	if Image.where(processed: nil)
		Label.transaction do
			require "google/cloud/vision"
			Google::Cloud::Vision.configure do |config|
			  config.project_id  = "lottery-220502"
			  config.credentials = File.join(Rails.root, 'lottery-c12cc4ecd43a.json')
			end

			@picked_images = Image.where(processed: nil)
			@picked_images.each do |picked_image|
				vision = Google::Cloud::Vision.new
				image = vision.image "https:"+picked_image.scan.url
				# document = image.document
				# @text=document.text
				#......................Label Detection..................................
				@label=image.labels
				@label.each do |label|
					label_instance = Label.new
					label_instance.description = label.description
					label_instance.score = label.score
					label_instance.image_id = picked_image.id
					label_instance.identification_code = label.mid
					label_instance.save
				end
				#...................Web Entity Detection................................ 
				web = image.web
				@web_entities=web.entities
				@web_entities.each do |web_entity|
					web_entity_instance = WebEntity.new
					web_entity_instance.description = web_entity.description
					web_entity_instance.score = web_entity.score
					web_entity_instance.image_id = picked_image.id
					web_entity_instance.identification_code = web_entity.entity_id
					web_entity_instance.save
				end
				picked_image.update(processed: true)
				puts "processed"
			end
		end
	else
	end
end