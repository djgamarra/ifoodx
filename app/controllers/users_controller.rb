class UsersController < ApplicationController
  def signup
  end

  def signup_view
    @user = User.new
    render :signup
  end

  def signin
    auth_p = auth_params[:user]
    email       = auth_p[:email]
    password    = auth_p[:password]
    @user       = User.find_by email: email
    if @user.nil? or not (@user.authenticate password)
      gon.push notice: 'Usuario o contraseña errados'
      @user = User.new email: email, password: password
      render :signin and return
    end
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def signin_view
    @user = User.new
    render :signin
  end

  private

  def user_params
  end

  def auth_params
    params.permit(user: %i[email password])
  end
end
