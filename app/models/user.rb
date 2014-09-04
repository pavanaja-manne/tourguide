class User < ActiveRecord::Base
  has_many :guides
  
  def self.create_login(auth)
    @user = User.new   
    @user.img = auth["info"]["image"] 
    @user.uid = auth["uid"]  
    @user.name = auth["info"]["name"] 
    @user.save!     
  end
  
end
