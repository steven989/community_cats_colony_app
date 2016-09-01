class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to look_up_colonies_path
    else
      flash.now[:alert] = 'Login failed'
      redirect_to(login_path, alert: 'Incorrect email or password')
    end
  end

  def destroy
    logout
    redirect_to(login_path, notice: 'Logout successful')
  end
end
