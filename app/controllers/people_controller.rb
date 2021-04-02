class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @all_persons = Person.all
    @counter = 0
    @all_persons.each do |person|
      @counter += 1 if person.point_verites.count > 0
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    ahoy.track "Profil consulté", id: @person.id, name: @person.displayed_name
    @scores = @person.scores
  end

  def image
    @person = Person.find(params[:id])
    @score = @person.scores.last
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  # def edit
  # end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(
      first_name: person_params["first_name"],
      last_name: person_params["last_name"],
      wikipedia_link: person_params["wikipedia_link"],
      nickname: person_params["nickname"],
    )
    @person.media = @person.define_media(person_params)
    @person.full_name = @person.first_name + " " + @person.last_name
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  # def update
  #   respond_to do |format|
  #     @person.media = @person.define_media(person_params)
  #     if @person.save
  #       format.html { redirect_to @person, notice: 'Person was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @person }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @person.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /people/1
  # DELETE /people/1.json
  # def destroy
  #   @person.destroy
  #   respond_to do |format|
  #     format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:first_name, :last_name, :wikipedia_link, :nickname, :youtube, :twitter, :instagram, :facebook)
    end
end
