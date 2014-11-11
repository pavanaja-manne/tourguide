class User < ActiveRecord::Base
  has_many :guides
  has_many :locations
  has_many :relationships
  has_many :followers, :class_name => 'Relationship', :foreign_key => 'followed_id'
  has_many :following, :class_name => 'Relationship', :foreign_key => 'follower_id'
  def self.create_login(auth)
    @user = User.new
    @user.img = auth["info"]["image"]
    @user.uid = auth["uid"]
    @user.name = auth["info"]["name"]
    @user.save!
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    following.create!(followed_id: other_user.id)
  #  users.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    following.find_by_followed_id(other_user.id).destroy
  end
  def to_param
    "#{self.name}"
  end

end
