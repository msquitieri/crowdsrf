# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    low_resolution "someURL"
    standard_resolution "someURL"
    link "someURL"
    thumbnail "someURL"
    instagram_id "myInstagramID"
  end
end
