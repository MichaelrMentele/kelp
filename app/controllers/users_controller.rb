class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Congratz! You're registered. You can now leave reviews."
      redirect_to businesses_path
    else
      flash[:errors] = "I'm sorry, there is something wrong with your information!"
      redirect_to register_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end