class FlatsController < ApplicationController
  before_action :set_flat, only: %i[ show edit update destroy ]

  # GET /flats or /flats.json
  def index
    @flats = Flat.all
  end

  # GET /flats/1 or /flats/1.json
  def show
    counters = @flat.counters
    @hot_counters = counters.where(water_type: :hot).order(:created_at)
    @cold_counters = counters.where(water_type: :cold).order(:created_at)
  end

  # GET /flats/new
  def new
    @flat = Flat.new
  end

  # GET /flats/1/edit
  def edit
  end

  def last_flat_counters
    @last_counters = []
    Flat.all.each do |flat|
      counters = flat.counters
      last_cold_counter = counters.where(water_type: :cold).last
      
      last_hot_counter = counters.where(water_type: :hot).last
      puts "counters = #{counters.where(water_type: :hot).inspect}"
      @last_counters << ({
        address: flat.address,
        
        hot_value: last_hot_counter&.value || "нет данных",
        last_hot_date: last_hot_counter&.created_at || "нет данных",
        cold_value: last_cold_counter&.value || "нет данных",
        last_cold_date: last_cold_counter&.created_at || "нет данных" ,

      })

    end
  end

  def debtor_list
    @debtors = []
    Flat.all.each do |flat|
      debtor = {}
      counters = Counter.where(flat_id: flat.id).where("created_at >= ?", Time.now.at_beginning_of_month)
      hot_counters = counters.where(water_type: :hot)
      cold_counters = counters.where(water_type: :cold)

      if hot_counters.size < 1
        debtor[:hot] = "отсутствуют показания горячей воды"
      end

      if cold_counters.size < 1
        debtor[:cold] = "отсутствуют показания холодной воды"
      end

      if (debtor[:hot] || debtor[:cold])
        debtor[:flat] = flat
        @debtors << debtor
      end
    end
  end



  # POST /flats or /flats.json
  def create
    @flat = Flat.new(flat_params)

    respond_to do |format|
      if @flat.save
        format.html { redirect_to @flat, notice: "Flat was successfully created." }
        format.json { render :show, status: :created, location: @flat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flats/1 or /flats/1.json
  def update
    respond_to do |format|
      if @flat.update(flat_params)
        format.html { redirect_to @flat, notice: "Flat was successfully updated." }
        format.json { render :show, status: :ok, location: @flat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flats/1 or /flats/1.json
  def destroy
    @flat.destroy
    respond_to do |format|
      format.html { redirect_to flats_url, notice: "Flat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flat_params
      params.require(:flat).permit(:address, :comment)
    end
end
