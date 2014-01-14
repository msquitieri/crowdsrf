require 'spec_helper'

describe "locations/edit" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :lat => 1.5,
      :lng => 1.5,
      :foursquare_id => "",
      :name => "MyString"
    ))
  end

  it "renders the edit location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", location_path(@location), "post" do
      assert_select "input#location_lat[name=?]", "location[lat]"
      assert_select "input#location_lng[name=?]", "location[lng]"
      assert_select "input#location_foursquare_id[name=?]", "location[foursquare_id]"
      assert_select "input#location_name[name=?]", "location[name]"
    end
  end
end
