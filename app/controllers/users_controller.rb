class UsersController < ApplicationController
  def create
    @user = User.new(user_params.merge!(img_url: "http://placehold.it/175x175"))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Congratz! You're registered. You can now leave reviews."
      redirect_to businesses_path
    else
      flash.now[:errors] = "I'm sorry, there is something wrong with your information!"
      render 'users/new'
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