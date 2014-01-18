require 'spec_helper'

describe Photo do
	before (:each) do
		@photo = FactoryGirl.create(:photo)
	end

	it 'should have a standard_resolution image' do
		@photo.standard_resolution.should be_present
	end

	it 'should have a low_resolution image' do
		@photo.low_resolution.should be_present
	end

	it 'should have a link' do
		@photo.link.should be_present
	end

	it 'should have an instagram_id' do
		@photo.instagram_id.should be_present
	end
end
