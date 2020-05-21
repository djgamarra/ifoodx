class OrdersController < ApplicationController
  before_action :require_logged_in

  def index
    @orders = @current_user.orders
    @ingredients = Ingredient.all
    ing          = {}
    @ingredients.each { |i| ing[i.id] = i }
    gon.push ingredients: ing
  end

  def show
  end

  def new
    @order       = Order.new
    @ingredients = Ingredient.all
    ing          = {}
    @ingredients.each { |i| ing[i.id] = i }
    gon.push ingredients: ing
  end

  def create
    debugger
  end
end
