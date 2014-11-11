class LocationsController < ApplicationController
  def delete
    @location = Location.find(params[:id])
    @location.delete
    render :text => "successfully deleted teh location"
  end
end
