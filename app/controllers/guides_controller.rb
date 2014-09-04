class GuidesController < ApplicationController
  before_filter :login_req, :except => ['index','search']
  # GET /guides
  # GET /guides.json
  def index   
    @browse_by = [["Browse By",''],["Guides",'1'],["Places",'2']]
    @characteristics = ["Latest",'1'],["Most Popular",'2'],["Highest Rated",'3'],["Stress Factor",'4']
    @notice = notice
    @guides = Guide.order("CREATED_AT DESC").all    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guides }
    end
  end

  # GET /guides/1
  # GET /guides/1.json
  def show
    @guide = Guide.find(params[:id])
    @location = Location.new
    if !(params[:ajax])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @guide }
      end
    end
  end
  
  
  ## GEt /guides/search
  def search
    @guides = Guide.where("city LIKE ?", "%#{params[:keyword]}%").order("CREATED_AT DESC")
    @template_format = "html"
    render :html => 'search', :layout => false
   # render :partial => 'search', :object => @guides, :layout => false, :formats => [:html]
  end

  # GET /guides/new
  # GET /guides/new.json
  def new
    @guide = Guide.new
    @stress_factor = [['1/10','1/10'],['2/10','2/10'],['3/10','3/10'],['4/10','4/10'],['5/10','5/10'],['6/10','6/10'],['7/10','7/10'],['8/10','8/10'],['9/10','9/10'],['10/10','10/10']]
    @pacing = [['Pacing Schmacing','Pacing Schmacing'],['Lazy','Lazy'],['Stay On Course','Stay On Course'],['Wha','Wha']]
    @category = [['Foodles','Foodles'],['Night Life','Night Life'],['Shopping','Shopping'],['Style','Style'],['Culture','Culture'],['Must See','Must See'],['Cheapo','Cheapo'],['Artsy','Artsy']]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guide }
    end
  end

  # GET /guides/1/edit
  def edit
    @guide = Guide.find(params[:id])
  end

  # POST /guides
  # POST /guides.json
  def create    
    @guide = Guide.new(params[:guide])
    respond_to do |format|
      if @guide.save
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

##Location- Create
  def location_create
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
    render :html => '/guides/'+params[:guide_id]+'?ajax=true', :layout => 'false'
  end
  
  
  # DELETE /guides/1
  # DELETE /guides/1.json
  def destroy
    @guide = Guide.find(params[:id])
    @guide.destroy

    respond_to do |format|
      format.html { redirect_to guides_url }
      format.json { head :no_content }
    end
  end
end
