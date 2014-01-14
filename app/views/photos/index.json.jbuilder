json.array!(@photos) do |photo|
  json.extract! photo, :id, :low_resolution, :standard_resolution, :link, :thumbnail, :location, :instagram_id
  json.url photo_url(photo, format: :json)
end
