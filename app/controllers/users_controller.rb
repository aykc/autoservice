class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.turbo_stream do
          flash.now[:success] = 'User has been created'
          render turbo_stream: turbo_stream.prepend(:users, @user) + \
            turbo_stream.update(:new_user, '') + \
            turbo_stream.replace(:flash, partial: 'layouts/flash')
        end
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@user, @user) }
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy

    respond_to do |format|
      if @user.destroy
        format.turbo_stream do
          flash.now[:success] = 'Successfully deleted'
          render turbo_stream: turbo_stream.remove(@user) + \
            turbo_stream.replace(:flash, partial: 'layouts/flash')
        end
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      else
        format.turbo_stream do
          flash.now[:alert] = 'Cant be deleted'
          render turbo_stream: turbo_stream.replace(@user, @user) + \
            turbo_stream.replace('flash', partial: 'layouts/flash')
        end
        format.html { redirect_to users_path, alert: "User can not be deleted!" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name)
    end
end
