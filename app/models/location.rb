class Location < ActiveRecord::Base
  belongs_to :guide
  belongs_to :user
end
