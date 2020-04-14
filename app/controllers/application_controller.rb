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
    unless user_id.nil?
      @current_user ||= User.find_by id: user_id
      @current_user = nil unless @current_user.id == user_id
    end
  end

  def require_logged_in
    flash[:auth] = 'Debe iniciar sesión primero'
    redirect_to login_path if @current_user.nil?
  end
end
