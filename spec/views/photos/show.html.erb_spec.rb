require 'spec_helper'

describe "photos/show" do
  before(:each) do
    @photo = assign(:photo, stub_model(Photo,
      :low_resolution => "Low Resolution",
      :standard_resolution => "Standard Resolution",
      :link => "Link",
      :thumbnail => "Thumbnail",
      :location => "",
      :instagram_id => "Instagram"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Low Resolution/)
    rendered.should match(/Standard Resolution/)
    rendered.should match(/Link/)
    rendered.should match(/Thumbnail/)
    rendered.should match(//)
    rendered.should match(/Instagram/)
  end
end
