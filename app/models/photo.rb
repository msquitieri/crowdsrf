class Photo < ActiveRecord::Base
	# What else does it need to validate??
	# validates , presence: true

	validates :instagram_id, uniqueness: true
	has_one :location

	def self.getNewPhotosFromLocation(location)
		# self.init_instagram
		Instagram.configure do |config|
			config.client_id = "d8e1909342004f1b926cf9bd538e6dd1"
		end

		instagram_location = Instagram.location_search(location.foursquare_id)
		unless instagram_location.empty?
			media = Instagram.location_recent_media(instagram_location.first.id)

			media.each do |photo|
				self.addPhotoWithLocation(photo, location)
			end
		end
	end

	private
	def self.init_instagram
		Instagram.configure do |config|
			config.client_id = "d8e1909342004f1b926cf9bd538e6dd1"
		end
	end

	def self.addPhotoWithLocation(photo, location) 
		photo_params = {}

		photo_params[:instagram_id] = photo.id
		photo_params[:low_resolution] = photo.images.low_resolution.url
		photo_params[:standard_resolution] = photo.images.standard_resolution.url
		photo_params[:thumbnail] = photo.images.thumbnail.url
		photo_params[:link] = photo.link
		photo_params[:location_id] = location.id

		Photo.create(photo_params)
	end
end
