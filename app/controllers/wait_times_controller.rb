class WaitTimesController < ApplicationController
  before_action :set_wait_time, only: [:show, :edit, :update, :destroy]

  before_action :user_is_admin?, :only => [:index, :edit, :update, :destroy]

  # GET /wait_times
  # GET /wait_times.json
  def index
    @wait_times = WaitTime.all
  end

  # GET /wait_times/1
  # GET /wait_times/1.json
  def show
  end

  # GET /wait_times/new
  def new
    @wait_time = WaitTime.new
  end

  # GET /wait_times/1/edit
  def edit
  end

  # POST /wait_times
  # POST /wait_times.json
  def create
    @wait_time = WaitTime.new(wait_time_params)

    respond_to do |format|
      if @wait_time.save
        format.html { redirect_to @wait_time, notice: 'Wait time was successfully created.' }
        format.json { render :show, status: :created, location: @wait_time }
      else
        format.html { render :new }
        format.json { render json: @wait_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wait_times/1
  # PATCH/PUT /wait_times/1.json
  def update
    respond_to do |format|
      if @wait_time.update(wait_time_params)
        format.html { redirect_to @wait_time, notice: 'Wait time was successfully updated.' }
        format.json { render :show, status: :ok, location: @wait_time }
      else
        format.html { render :edit }
        format.json { render json: @wait_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wait_times/1
  # DELETE /wait_times/1.json
  def destroy
    @wait_time.destroy
    respond_to do |format|
      format.html { redirect_to wait_times_url, notice: 'Wait time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wait_time
      @wait_time = WaitTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wait_time_params
      params.require(:wait_time).permit(:restaurant_id, :party_size, :minutes, :checked_at)
    end
end
