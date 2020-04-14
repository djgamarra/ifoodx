class ApplicationController < ActionController::Base
  helper_method :logged_in?
  before_action :set_current_user

  def index
    render 'index'
  end

  def logged_in?
    not @current_user.nil?
  end

  private

  def set_current_user
    @current_user ||= if session[:user_id].nil?
                        nil
                      else
                        User.find_by id: session[:user_id]
                      end
  end

  def require_logged_in
    flash[:auth] = 'Debe iniciar sesión primero'
    redirect_to login_path if @current_user.nil?
  end
end
