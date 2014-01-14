json.code 200

json.response do |json| 
	json.venues do |json|
		json.array!(@locations) do |location|
		    json.extract! location, :id, :lat, :lng, :foursquare_id, :name
            json.link location_path(location)

		  	json.photos do |json|
		  		json.array!(location.photos) do |photo|
		  			json.extract! photo, :low_resolution, :standard_resolution, :link, :id, :instagram_id, :thumbnail
		  		end
		  	end
		end
	end
end
