class UsersController < ApplicationController
  before_action :set_user, only: [:add_arrival, :add_departure, :show, :edit, :update, :destroy]

  before_filter :authenticate!, :only => [:add_arrival, :add_departure, :edit, :update, :show, :destroy]

  def index
    if logged_in?
      set_user
      redirect_to @user
    else
      redirect_to new_user_path
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
    session.clear
  end

  def add_arrival
    time = Time.now
    ticket = @user.time_tickets.new
    ticket.arrival = time
    ticket.date = time
    ticket.departure = time
    ticket.is_finished = false

    respond_to do |format|
      if ticket.save
        format.html { redirect_to :back, notice: 'Arrival Date was successfully logged.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_departure
    time = Time.now
    ticket = @user.time_tickets.last
    ticket.departure = time
    ticket.is_finished = true

    respond_to do |format|
      if ticket.save
        format.html { redirect_to @user, notice: 'Departure Date was successfully logged.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(session[:user])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
