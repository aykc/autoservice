class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
        format.turbo_stream do
          render turbo_stream:  turbo_stream.append(:categories, @category) + \
                                turbo_stream.remove("new_category") + \
                                turbo_stream.replace('flash', partial: 'layouts/flash', \
                                                     locals: { flash: { notice: 'Category was successfully added'}})
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.turbo_stream do
          render turbo_stream:  turbo_stream.replace("category_#{@category.id}", @category) + \
                                turbo_stream.replace('flash', partial: 'layouts/flash', \
                                                     locals: { flash: { notice: 'Category was successfully updated' } })
        end
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:  turbo_stream.remove(@category) + \
                              turbo_stream.replace('flash', partial: 'layouts/flash', \
                                                   locals: { flash: { notice: 'Category was successfully deleted' } })

      end
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.includes(:services).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
