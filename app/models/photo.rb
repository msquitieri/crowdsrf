class Photo < ActiveRecord::Base
	# need at least a standard_resolution and low_resolution.
	validates :standard_resolution, :low_resolution, :link, presence: true

	# belongs_to_and_has_many when it comes to tags????

	validates :instagram_id, uniqueness: true
	belongs_to :location
	belongs_to :tag

	def self.getNewPhotosFromLocation(location)
		self.init_instagram
		
		instagram_location = Instagram.location_search(location.foursquare_id)
		unless instagram_location.empty?
			media = Instagram.location_recent_media(instagram_location.first.id)

			media.each do |photo|
				self.addPhotoWithLocation(photo, location)
			end
		end
	end

	def self.getNewPhotosFromTag(tag) 
		self.init_instagram

		photos = Instagram.tag_recent_media(tag.name)
		photos.each do |photo|
			self.addPhotoWithTag(photo, tag)
		end
	end

	private

	def self.init_instagram
		Instagram.configure do |config|
			config.client_id = "d8e1909342004f1b926cf9bd538e6dd1"
		end
	end

	def self.addPhotoWithTag(photo, tag) 
		@photo = Photo.find_by_instagram_id(photo.id)

		if @photo.nil?
			photo_params = self.getParamsHashFromPhoto(photo)
			photo_params[:tag_id] = tag.id

			@photo = Photo.create(photo_params)
		else
			@photo.tag = tag
			@photo.save
		end

		return @photo
	end

	def self.addPhotoWithLocation(photo, location) 
		@photo = Photo.find_by_instagram_id(photo.id)

		if @photo.nil?
			photo_params = self.getParamsHashFromPhoto(photo)
			photo_params[:location_id] = location.id

			@photo = Photo.create(photo_params)
		else
			@photo.location = location
			@photo.save
		end

		return @photo
	end

	def self.getParamsHashFromPhoto(photo)
		photo_params = {}

		photo_params[:instagram_id] = photo.id
		photo_params[:low_resolution] = photo.images.low_resolution.url
		photo_params[:standard_resolution] = photo.images.standard_resolution.url
		photo_params[:thumbnail] = photo.images.thumbnail.url
		photo_params[:link] = photo.link

		photo_params
	end
end
