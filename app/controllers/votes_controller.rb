class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new]
  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @source = Source.find(params[:source_id])
    if @source.is_correct.nil?
      @validation_in_progress = true
      @vote = Vote.new(source_id: params[:source_id])
      @person = Person.find(@source.person_id)
      @already_vote = false
      @message = Message.new
      unless Vote.where(source_id: @source.id, user_id: current_user.id).last.nil?
        @already_vote = true
      end
    else
      @validation_in_progress = false
    end
  end

  # GET /votes/1/edit
  # def edit
  # end

  # POST /votes
  # POST /votes.json
  def create

    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
    @vote.points = current_user.points
    @vote.is_admin_vote = current_user.admin_status

    source = Source.find(@vote.source_id)
    respond_to do |format|
      if Vote.where(source_id: @vote.source_id, user_id: @vote.user_id).last.nil? && source.is_correct == nil && @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  # def update
  #   respond_to do |format|
  #     if @vote.update(vote_params)
  #       format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @vote }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @vote.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /votes/1
  # # DELETE /votes/1.json
  # def destroy
  #   @vote.destroy
  #   respond_to do |format|
  #     format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:source_id, :is_validated, :tag_id)
    end
end
