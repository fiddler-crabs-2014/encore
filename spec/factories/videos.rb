# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video, :class => 'Videos' do
    identifier "MyString"
  end
end
