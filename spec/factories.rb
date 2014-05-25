FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "123456"
    name "Jared Rader"
    oauth_token "123456"
    oauth_expires_at (Time.now + 1.week)
    sequence(:email) { |n| "user-#{n}@gmail.com" }
  end
end
