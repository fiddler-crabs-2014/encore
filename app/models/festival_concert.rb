class FestivalConcert < ActiveRecord::Base
  belongs_to :festival_date
  belongs_to :concert
end
