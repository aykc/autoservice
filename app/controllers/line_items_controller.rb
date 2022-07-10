class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[edit update destroy]

  def new
    @order = Order.find params[:order_id]
    @line_item = @order.line_items.new
  end

  def edit
  end

  def create
    @order = Order.find params[:order_id]
    @line_item = @order.line_items.new(line_item_params)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to order_url(@order), notice: "Service was successfully added." }
        format.json { render :show, status: :created, location: @order }
        format.turbo_stream { render turbo_stream: turbo_stream.append(:line_items, @line_item) + \
                              turbo_stream.remove("new_order_#{@order.id}_line_item") + \
                              turbo_stream.replace('flash', partial: 'layouts/flash', locals: {flash: { notice: 'Service successfully added' } })}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("line_item_#{@line_item.id}", @line_item) + \
                              turbo_stream.replace('flash', partial: 'layouts/flash', locals: {flash: { notice: 'Service successfully updated' } })}
        format.html { redirect_to_back_or line_item_path(@line_item), notice: "Service was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@line_item) + \
                            turbo_stream.replace('flash', partial: 'layouts/flash', locals: {flash: { notice: 'Service successfully removed' } })}
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
