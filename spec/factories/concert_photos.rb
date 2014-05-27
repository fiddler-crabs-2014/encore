# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :concert_photo do
    user nil
    concert nil
    image "MyString"
  end
end
