class SessionController < ApplicationController
  def new
    if logged_in?
      redirect_to "/users/show"
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(name: session_params[:name]).try :authenticate, session_params[:password]
    if @user
      session[:user] = @user.id
      flash[:notice] = 'Login Successful'
      redirect_to user_path(:id => @user.id)
    else
      @user = User.new
      flash[:error] = 'Wrong Name or Password'
      render :new
    end
  end

  def destroy
    redirect_to login_path, notice: 'Not logged in' and return if session[:user].blank?
    session[:user] = nil
    redirect_to root_path, notice: 'Logged out'
  end

  def session_params
    params.require(:user).permit(:name, :password) if params[:user]
  end
end