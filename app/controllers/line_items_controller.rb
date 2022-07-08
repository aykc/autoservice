class LineItemsController < ApplicationController
  before_action :set_line_item, only: :destroy

  def new
    @order = Order.find params[:order_id]
    @line_item = @order.line_items.new
  end

  def create
    @order = Order.find params[:order_id]
    @line_item = @order.line_items.new(line_item_params)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to order_url(@order), notice: "Service was successfully added." }
        format.json { render :show, status: :created, location: @order }
        # format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to order_path(@line_item.order), notice: "Service was successfully removed." }
      format.json { head :no_content }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find params[:id]
  end

  def line_item_params
    params.require(:line_item).permit(:order_id, :user_id, :service_id)
  end
end
