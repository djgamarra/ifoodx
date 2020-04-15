class UsersController < ApplicationController
  before_action :require_logged_in, only: %i[account signout]
  before_action :require_unlogged_in, except: %i[account signout]

  def account
  end

  def signup
    user_p = user_params[:user]

    user_p[:password_confirmation] = user_p[:password]

    @user = User.new user_p
    render :signup and return unless @user.valid?
    unless @user.save
      gon.push notice: 'Error al crear la cuenta'
      render :signup and return
    end
    gon.push notice: 'Cuenta creada correctamente'
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def signup_view
    @user = User.new
    render :signup
  end

  def signin
    auth_p   = auth_params
    email    = auth_p[:user][:email]
    password = auth_p[:user][:password]
    @user    = User.find_by email: email
    if @user.nil? or not (@user.authenticate password)
      gon.push notice: 'Usuario o contraseña errados'
      @user = User.new auth_p[:user]
      render :signin and return
    end
    gon.push notice: 'Sesión iniciada correctamente'
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def signin_view
    @user = User.new
    render :signin
  end

  def signout
    session.delete :user_id
    redirect_to root_path
  end

  private

  def user_params
    params.permit(user: %i[email password first_name last_name phone_number address])
  end

  def auth_params
    params.permit(user: %i[email password])
  end
end
