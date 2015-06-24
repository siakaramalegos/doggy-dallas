class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  # GET /dogs
  # GET /dogs.json
  def index
    if params[:search]
      @dogs = Dog.where("name LIKE '%#{params[:search]}%'")
      if @dogs.size.zero?
        flash[:notice] = "No result found for \"#{params[:search]}\"."
        @dogs = Dog.all
      end
    else
      @dogs = Dog.all
    end
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  # POST /dogs.json
  def create
    # TODO:  Fix authenticity token error when trying to upload file with create.
    @dog = Dog.new(dog_params)
    @dogs = Dog.all

    respond_to do |format|
      if @dog.save
        format.html { redirect_to @dog }
        format.js {}
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.js { render :action => "new"}
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    @dogs = Dog.all

    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to dogs_path, notice: 'Dog was successfully updated.' }
        format.js {}
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.js { render :action => "edit" }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :owner_id, :breed_id, :dob, :vet, :vet_phone, :in_daycare, :dietary_restriction, :avatar)
    end
end
