class Location < ActiveRecord::Base
	has_many :photos
	validates :lat, :lng, :foursquare_id, :name, presence: true
	validates :foursquare_id, uniqueness: true

	def self.addFoursquareLocation (foursquare_location)
		location_params = {};

		location_params[:foursquare_id] = foursquare_location.id
		location_params[:lat] = foursquare_location.location.lat
		location_params[:lng] = foursquare_location.location.lng
		location_params[:name] = foursquare_location.name

		return Location.create(location_params)
	end
end