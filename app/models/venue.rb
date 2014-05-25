class Venue < ActiveRecord::Base
  validates :name, :city, :state, presence: true

  has_many :concerts
end
