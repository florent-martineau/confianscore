class PointVeritesController < ApplicationController
  before_action :set_point_verite, only: [:show, :edit, :update, :destroy]

  # GET /point_verites
  # GET /point_verites.json
  def index
    @point_verites = PointVerite.all
  end

  # GET /point_verites/1
  # GET /point_verites/1.json
  def show
  end

  # GET /point_verites/new
  def new
    @point_verite = PointVerite.new
  end

  # GET /point_verites/1/edit
  def edit
  end

  # POST /point_verites
  # POST /point_verites.json
  def create
    @point_verite = PointVerite.new(point_verite_params)

    respond_to do |format|
      if @point_verite.save
        format.html { redirect_to @point_verite, notice: 'Point verite was successfully created.' }
        format.json { render :show, status: :created, location: @point_verite }
      else
        format.html { render :new }
        format.json { render json: @point_verite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /point_verites/1
  # PATCH/PUT /point_verites/1.json
  def update
    respond_to do |format|
      if @point_verite.update(point_verite_params)
        format.html { redirect_to @point_verite, notice: 'Point verite was successfully updated.' }
        format.json { render :show, status: :ok, location: @point_verite }
      else
        format.html { render :edit }
        format.json { render json: @point_verite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /point_verites/1
  # DELETE /point_verites/1.json
  def destroy
    @point_verite.destroy
    respond_to do |format|
      format.html { redirect_to point_verites_url, notice: 'Point verite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point_verite
      @point_verite = PointVerite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def point_verite_params
      params.require(:point_verite).permit(:person_id, :value)
    end
end
