class GuidesController < ApplicationController
  before_filter :login_req, :except => ['index','search','display']
  skip_before_filter  :verify_authenticity_token
  # GET /guides
  # GET /guides.json
  def index    
    ip_addr = request.env['REMOTE_ADDR']    
    @browse_by = [["Browse By",''],["Guides",'1'],["Places",'2']]
    @characteristics = ["Latest",'1'],["Most Popular",'2'],["Highest Rated",'3'],["Stress Factor",'4']
    @notice = notice
    @guides = Guide.where("publish=?",true).order("CREATED_AT DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guides }
    end
  end

  # GET /guides/1
  # GET /guides/1.json
  def show
    @guide = Guide.find(params[:id])
    @location_categories = [['select Category',""],['Foodies','Foodies'],['Night Life','Night Life'],['Shopping','Shopping'],['Style','Style'],['Culture','Culture'],['Must See','Must See'],['Cheapo','Cheapo'],['Artsy','Artsy']]
    if !(params[:ajax])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @guide }
      end
    end
  end


  ##GET /guides/display
  def display
    @guide = Guide.find(params[:id])
    @locations = Location.where('guide_id=?',params[:id].to_i)
    puts @locations.inspect
    #return false
    if(request.xhr?)
      render :html => 'display', :layout => false
    else
      render :html => 'display'
    end
  end

  ## GEt /guides/search
  def search
    if !(params[:key].nil?)
        @guides = Guide.where("city LIKE ?", "%#{params[:keyword]}%").order("CREATED_AT DESC")
        @template_format = "html"
    else
      if(params[:key] == 'stress')
        @guides = Guide.order("stress_factor DESC").all
      end
    end
    render :html => 'search', :layout => false
   # render :partial => 'search', :object => @guides, :layout => false, :formats => [:html]
  end

  # GET /guides/new
  # GET /guides/new.json
  def new
    @guide = Guide.new
    @stress_factor = [['Stress Level',''],['1/5','1/5'],['2/5','2/5'],['3/5','3/5'],['4/5','4/5'],['5/5','5/5']]
    @pacing = [['Pacing Schmacing','Pacing Schmacing'],['Lazy','Lazy'],['Stay On Course','Stay On Course']]
    @category = [['Select Category',''],['Foodies','Foodies'],['NightLife','NightLife'],['Shopping','Shopping'],['Style','Style'],['Culture','Culture'],['MustSee','MustSee'],['Cheapo','Cheapo'],['Artsy','Artsy']]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guide }
    end
  end

  # GET /guides/1/edit
  def edit
    @guide = Guide.find(params[:id])
    @locations = @guide.locations
    @location_categories = [['Foodles','Foodles'],['Night Life','Night Life'],['Shopping','Shopping'],['Style','Style'],['Culture','Culture'],['Must See','Must See'],['Cheapo','Cheapo'],['Artsy','Artsy']]
  end

  # POST /guides
  # POST /guides.json
  def create
    @guide = Guide.new(params[:guide])
    respond_to do |format|
      if @guide.save
        params[:user_name] = nil
        format.html { redirect_to guide_url(@guide), notice: 'Guide was successfully created.' }
        format.json { render json: @guide, status: :created, location: @guide }
      else
        format.html { render action: "new" }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guides/1
  # PUT /guides/1.json
  def update
    @guide = Guide.find(params[:id])

    respond_to do |format|
      if @guide.update_attributes(params[:guide])
        format.html { redirect_to @guide, notice: 'Guide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end



  def location_create_fsq
    @user = User.find_by_uid(session[:user_id])
    @l_exist = Location.where(:foursquare_id => params[:fsq_id], :user_id => @user.id)
    if(@l_exist.blank?)
      @location = Location.new
      #@user = User.find_by_uid(session[:user_id])
      @location.foursquare_id = params[:fsq_id]
      @location.foursquare_image_url = params[:image_url]
      @location.category = params[:category]
      @location.user_id = @user.id
      @location.name = params[:name]
      @location.address = params[:address]
     if @location.save!
       render :text => 'successfully created location.'
     else
        render :text => "Failed to save the location."
      end
    else
      render :text => "you have already added the location"
    end

  end


  def location_delete_fsq
    @l = Location.where(:foursquare_id => params[:fsq_id], :user_id => @user.id)
    @l.destroy_all
    render :text => "Deleted Successfully."

  end

##Location- Create
  def location_create
    @guide = Guide.find(params[:guide_id])
    @location_categories = [['Foodles','Foodles'],['Night Life','Night Life'],['Shopping','Shopping'],['Style','Style'],['Culture','Culture'],['Must See','Must See'],['Cheapo','Cheapo'],['Artsy','Artsy']]
    @location = Location.new()
    @location.name = params[:name]
    @location.foursquare_image_url = params[:image]
    @location.why_i_like = params[:about]
    @location.long = params[:long]
    @location.lat = params[:lat]
    @location.category = params[:category]
    @location.guide_id = params[:guide_id]
    @location.foursquare_id = params[:foursquare_id]
    @location.save
    @template_format = "html"
    render :html => 'location_create', :layout => false
  end


  def search_category
     @guides = Guide.where("category=?",params[:category])
     respond_to do |format|
      format.js {}
     end
  end

  def publish_guide
    @guide = Guide.find(params[:id].to_i)
    @guide.publish = true
    @guide.save
    UpdateEmail.followerNews("raghava.sangars@gmail.com").deliver
    render :text => "success"
  end

  # DELETE /guides/1
  # DELETE /guides/1.json
  def delete
    @guide = Guide.find(params[:id])
    @guide.destroy
    respond_to do |format|
      format.html { redirect_to guides_url }
      format.json { head :no_content }
    end
  end
end
