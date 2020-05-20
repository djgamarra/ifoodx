class OrdersController < ApplicationController
  before_action :require_logged_in

  def index
    @orders = @current_user.orders
  end

  def show
  end

  def new
  end

  def create
  end
end
