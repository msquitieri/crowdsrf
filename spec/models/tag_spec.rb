require 'spec_helper'

describe Tag do
	before(:each) do
		@tag = FactoryGirl.create(:tag)
	end

	it 'should have a name' do
		@tag.name.should be_present
	end
end
