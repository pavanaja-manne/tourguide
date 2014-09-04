class UsersController < ApplicationController
  def profile
    @user = User.find_by_uid(session[:user_id])
    @guides = Guide.where("user_id = ?",@user.id)
    puts "guides"
    puts @guides
  end
  def edit    
    @user = User.find_by_uid(session[:user_id])
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
