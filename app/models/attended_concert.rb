class AttendedConcert < ActiveRecord::Base
  validates :concert_id, presence: true
  validates :user_id, presence: true

  belongs_to :concert
  belongs_to :user

  validates_uniqueness_of :concert_id, scope: :user_id
end
