class CommentairesController < ApplicationController
  before_action :set_commentaire, only: [:show, :edit, :update, :destroy]

  # GET /commentaires
  # GET /commentaires.json
  # def index
  #   @commentaires = Commentaire.all
  # end

  # GET /commentaires/1
  # GET /commentaires/1.json
  def show
  end

  # GET /commentaires/new
  def new
    @commentaire = Commentaire.new(source_id: params[:source_id])
  end

  # GET /commentaires/1/edit
  def edit
  end

  # POST /commentaires
  # POST /commentaires.json
  def create
    @commentaire = Commentaire.new(commentaire_params)

    respond_to do |format|
      if @commentaire.save
        format.html { redirect_to @commentaire, notice: 'Commentaire was successfully created.' }
        format.json { render :show, status: :created, location: @commentaire }
      else
        format.html { render :new }
        format.json { render json: @commentaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commentaires/1
  # PATCH/PUT /commentaires/1.json
  def update
    respond_to do |format|
      @new_commentaire = Commentaire.new(commentaire_params)
      if @new_commentaire.save
        format.html { redirect_to @new_commentaire, notice: 'Commentaire was successfully updated.' }
        format.json { render :show, status: :ok, location: @new_commentaire }
      else
        format.html { render :edit }
        format.json { render json: @new_commentaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commentaires/1
  # DELETE /commentaires/1.json
  # def destroy
  #   @commentaire.destroy
  #   respond_to do |format|
  #     format.html { redirect_to commentaires_url, notice: 'Commentaire was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commentaire
      @commentaire = Commentaire.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def commentaire_params
      params.require(:commentaire).permit(:source_id, :content)
    end
end
