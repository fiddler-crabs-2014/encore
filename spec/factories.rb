require 'faker'

FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "123456"
    name "Jared Rader"
    oauth_token "123456"
    oauth_expires_at (Time.now + 1.week)
    sequence(:email) { |n| "user-#{n}@gmail.com" }
  end

  factory :artist do
    name { Faker::Name.first_name }
  end

  factory :concert do
    date Date.new(2014, 5, 24)
    venue
  end

  factory :invalid_concert, parent: :concert do
    date nil
    venue_id nil
  end

  factory :venue do
    name { Faker::Company.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
  end

  factory :concert_song do
    concert
    song
    video_identifier { Faker::Code.isbn }
  end

  factory :song do
    artist
    title { Faker::Lorem.word(1) }
  end
end

FactoryGirl.define do
  factory :artist do
    name "Muse"
  end
end
