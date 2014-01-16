require 'spec_helper'

describe Location do
	before (:each) do 
		@location = FactoryGirl.create(:location)
	end

	it 'should have lat and lng' do 
		@location.lat.should be_present
		@location.lng.should be_present
	end
end
