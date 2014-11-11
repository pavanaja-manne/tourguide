class UsersController < ApplicationController
  before_filter :login_req
  def profile    
    if params[:user_id].nil?
      @user = User.find_by_uid(session[:user_id])
    else
      @user = User.find(params[:user_id])
    end
    @guides = Guide.where(:user_id => @user.id,:publish => true).order("CREATED_AT DESC")
    puts "guides"
    puts @guides
  end
  
  
  def edit    
    @user = User.find_by_uid(session[:user_id])
  end
  
  ##follow_users_details
  def follow_users_details
    @user = User.find(params[:id])
    if params[:following_ids]
      following = @user.following
      following_ids = following.map{|x| x.followed_id}
      @follow_users = User.find(following_ids)
    end
    if params[:follower_ids]
      followers = @user.followers
      follower_ids = followers.map{|x| x.follower_id}
      @follow_users = User.find(follower_ids)
    end
    respond_to do |format|
      format.js {}
    end
    #render :html => 'follow_users_details', :layout => false
  end

  ##follow user
  def follow_user
    @user = User.find_by_uid(session[:user_id])
    @other_user = User.find(params[:other_user_id])
    @user.following.create!(followed_id:@other_user.id)
    render :text => 'following successfully'
  end
  
  ##unfollow user
  def unfollow_user
    @user = User.find_by_uid(session[:user_id])
    @other_user = User.find(params[:other_user_id])
    @user.following.find_by_followed_id(@other_user.id).destroy
    render :text => 'unfollowing successfully'
  end
  
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :action => 'profile', notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
