class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Congratz! You're registered. You can now leave reviews."
    else

    end

    redirect_to login_path
  end

  def show

  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end