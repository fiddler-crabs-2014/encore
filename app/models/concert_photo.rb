class ConcertPhoto < ActiveRecord::Base
  belongs_to :user
  belongs_to :concert

  mount_uploader :image, ConcertPhotoUploader 
end
