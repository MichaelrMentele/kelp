class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = "You are already signed in."
      redirect_to businesses_path
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome! You are now signed in."
      redirect_to businesses_path
    else
      flash[:errors] = "Sorry, there is a problem with your information."
      render 'sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to businesses_path
  end
end