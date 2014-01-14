require 'spec_helper'

describe "photos/index" do
  before(:each) do
    assign(:photos, [
      stub_model(Photo,
        :low_resolution => "Low Resolution",
        :standard_resolution => "Standard Resolution",
        :link => "Link",
        :thumbnail => "Thumbnail",
        :location => "",
        :instagram_id => "Instagram"
      ),
      stub_model(Photo,
        :low_resolution => "Low Resolution",
        :standard_resolution => "Standard Resolution",
        :link => "Link",
        :thumbnail => "Thumbnail",
        :location => "",
        :instagram_id => "Instagram"
      )
    ])
  end

  it "renders a list of photos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Low Resolution".to_s, :count => 2
    assert_select "tr>td", :text => "Standard Resolution".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Thumbnail".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Instagram".to_s, :count => 2
  end
end
