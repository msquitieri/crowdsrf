require 'spec_helper'

describe Location do
	before (:each) do 
		@location = FactoryGirl.create(:location)
	end

	it 'should have lat and lng' do 
		@location.lat.should be_present
		@location.lng.should be_present
	end

	it 'should have a foursquare_id' do
		@location.foursquare_id.should be_present
	end

	it 'should have a name' do
		@location.name.should be_present
	end
end
