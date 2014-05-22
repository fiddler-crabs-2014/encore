class Venue < ActiveRecord::Base
  has_many :concerts
end
