require 'spec_helper'

describe "photos/new" do
  before(:each) do
    assign(:photo, stub_model(Photo,
      :low_resolution => "MyString",
      :standard_resolution => "MyString",
      :link => "MyString",
      :thumbnail => "MyString",
      :location => "",
      :instagram_id => "MyString"
    ).as_new_record)
  end

  it "renders new photo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", photos_path, "post" do
      assert_select "input#photo_low_resolution[name=?]", "photo[low_resolution]"
      assert_select "input#photo_standard_resolution[name=?]", "photo[standard_resolution]"
      assert_select "input#photo_link[name=?]", "photo[link]"
      assert_select "input#photo_thumbnail[name=?]", "photo[thumbnail]"
      assert_select "input#photo_location[name=?]", "photo[location]"
      assert_select "input#photo_instagram_id[name=?]", "photo[instagram_id]"
    end
  end
end
