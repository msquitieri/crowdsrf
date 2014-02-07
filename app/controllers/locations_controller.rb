class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :init_foursquare, only: [:index]

  # GET /locations
  # GET /locations.json
  def index
    # @locations = Location.all
    @locations = []

    version = "20140206"       # YYYYMMDD required for all foursquare API calls as of 1/28/14

    latlng = "#{location_params[:lat]},#{location_params[:lng]}"
    response = @foursquare.search_venues(:ll => latlng, :v => version);
    foursquare_locations = response.venues

    foursquare_locations.each do |foursquare_location|
      location = Location.find_by_foursquare_id(foursquare_location.id)
      location = Location.addFoursquareLocation(foursquare_location) if location.nil?

      @locations.push(location)
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    Photo.getNewPhotosFromLocation(@location);
    @location.reload
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    def init_foursquare
      client_id = "2LTW1HFVHXSL3JDOBVF2VP252BUFHL52MVDQQTYBGLHTEH3L"
      client_secret = "5E20JUCKOLLTJOEXAZSX44CBRSLETZZ1TKVNFUC1TVQ0F521"

      @foursquare = Foursquare2::Client.new(:client_id => client_id, :client_secret => client_secret)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:lat, :lng, :foursquare_id, :name)
    end
end
