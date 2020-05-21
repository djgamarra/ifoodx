class ApplicationController < ActionController::Base
  helper_method :logged_in?
  before_action :set_current_user

  def index
  end

  def logged_in?
    not @current_user.nil?
  end

  private

  def set_current_user
    user_id = session[:user_id]
    if user_id.nil?
      @current_user = nil
    else
      @current_user = User.find_by id: user_id
    end
  end

  def require_logged_in
    if @current_user.nil?
      gon.push notice: 'Debe iniciar sesión primero'
      redirect_to signin_view_path
    end
  end

  def require_unlogged_in
    unless @current_user.nil?
      gon.push notice: 'Ya inició sesión'
      redirect_to root_path
    end
  end
end
