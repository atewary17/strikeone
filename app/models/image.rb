class Image < ActiveRecord::Base
	belongs_to :personnel
	has_many :labels
	has_many :web_entities
	has_attached_file :scan, :storage => :s3, :bucket => ENV['S3_BUCKET_NAME'], :s3_region => ENV['AWS_REGION'], :path => "image/scans/:id", :url => ":s3_domain_url"
    validates_attachment_size :scan, :in => 0.megabytes..10.megabytes
    do_not_validate_attachment_file_type :scan
end
