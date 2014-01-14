# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    low_resolution "MyString"
    standard_resolution "MyString"
    link "MyString"
    thumbnail "MyString"
    location ""
    instagram_id "MyString"
  end
end
