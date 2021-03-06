class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @q = Order.ransack params[:q]
    @orders = @q.result(distinct: true).left_joins(line_items: [{ service: :category }, :user]).includes(line_items: [{ service: :category }, :user])
    # @orders = Order.all
    respond_to do |format|
      format.html
      format.xlsx { render 'index', layout: false }
    end
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @line_item = @order.line_items.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
        format.turbo_stream do
          render turbo_stream:  turbo_stream.append(:orders, @order) + \
                                turbo_stream.update("new_order", '') + \
                                turbo_stream.replace('flash', partial: 'layouts/flash', \
                                                     locals: { flash: { notice: 'Order was successfully added' }})
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.turbo_stream do
          render turbo_stream:  turbo_stream.replace("order_#{@order.id}", @order) + \
                                turbo_stream.replace('flash', partial: 'layouts/flash', \
                                                     locals: {flash: { notice: 'Order was successfully updated' } })
        end
        format.html { redirect_to order_path(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:  turbo_stream.remove(@order) + \
                              turbo_stream.replace('flash', partial: 'layouts/flash', \
                                                   locals: { flash: { notice: 'Order successfully removed' } })
      end
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.includes(line_items: [:service, :user]).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer_name, :phone_number, :email, line_items_attributes: [:id, :service_id, :user_id])
    end
end
