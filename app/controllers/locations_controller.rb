class LocationsController < ApplicationController
  def create
    puts "----"
    puts params.inspect
    @location = Location.new()
    @location.name = params[:name]
    @location.tag = params[:tag]
    @location.about = params[:about]
    @location.long = params[:long]
    @location.lat = params[:lat]
    @location.guide_id = params[:guide_id]    
    @location.save    
    render :html => '/guides/show', :layout => 'false'
  end
end
