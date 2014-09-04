class Guide < ActiveRecord::Base
  belongs_to :user
  has_many :locations, :foreign_key => :guide_id
end
