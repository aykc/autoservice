class ServicesController < ApplicationController
  before_action :set_service, only: %i[ show edit update destroy ]

  # GET /services or /services.json
  def index
    @category = Category.includes(:services).find params[:category_id]
    @service = @category.services.new
    @services = @category.services.all
  end

  # GET /services/1 or /services/1.json
  def show
  end

  # GET /services/new
  def new
    @category = Category.find params[:category_id]
    @service = @category.services.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services or /services.json
  def create
    @category = Category.find params[:category_id]
    @service = @category.services.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to service_url(@service), notice: "Service was successfully created." }
        format.json { render :show, status: :created, location: @service }
        format.turbo_stream { render turbo_stream: turbo_stream.append(:services, @service)+turbo_stream.remove("new_category_#{@category.id}_service")}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1 or /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("service_#{@service.id}", @service) }
        format.html { redirect_to service_url(@service), notice: "Service was successfully updated." }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1 or /services/1.json
  def destroy
    @service.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@service)}
      format.html { redirect_back_or_to @service.category, notice: "Service was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_params
      params.require(:service).permit(:name, :price, :category_id)
    end
end
