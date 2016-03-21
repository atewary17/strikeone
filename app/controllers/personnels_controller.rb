class PersonnelsController < ApplicationController
  before_action :set_personnel, only: [:show, :edit, :update, :destroy]

  # GET /personnels
  # GET /personnels.json
  def index
    @personnels = Personnel.all
  end

  # GET /personnels/1
  # GET /personnels/1.json
  def show
  end

  # GET /personnels/new
  def new
    @personnel = Personnel.new
  end

  # GET /personnels/1/edit
  def edit
  end

  # POST /personnels
  # POST /personnels.json
  def create
    @personnel = Personnel.new(personnel_params)

    respond_to do |format|
      if @personnel.save
        format.html { redirect_to log_in_url, :notice => "Signed up!"  }
        format.json { render action: 'show', status: :created, location: @personnel }
      else
        format.html { render action: 'new' }
        format.json { render json: @personnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personnels/1
  # PATCH/PUT /personnels/1.json
  def update
    respond_to do |format|
      if @personnel.update(personnel_params)
        format.html { redirect_to @personnel, notice: 'Personnel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personnel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personnels/1
  # DELETE /personnels/1.json
  def destroy
    @personnel.destroy
    respond_to do |format|
      format.html { redirect_to personnels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personnel
      @personnel = Personnel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personnel_params
      params.require(:personnel).permit(:email, :name, :passwordhash, :passwordsalt, :auth_token, :password_reset_token, :password_reset_sent_at, :mobile, :password_confirmation, :password)
    end
end
