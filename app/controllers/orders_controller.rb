class OrdersController < ApplicationController
  before_action :require_logged_in

  def index
    @orders      = @current_user.orders.preload(:ingredients)
    @ingredients = Ingredient.all
    ing          = {}
    @ingredients.each { |i| ing[i.id] = i }
    gon.push ingredients: ing
  end

  def show
    @order = Order.find_by id: params[:id]
  end

  def new
    @order       = Order.new
    @ingredients = Ingredient.all
    ing          = {}
    @ingredients.each { |i| ing[i.id] = i }
    gon.push ingredients: ing
  end

  def create
    p        = order_params
    p[:user] = @current_user
    @order   = Order.create p
    params.require(:order).permit(ingredients: {})[:ingredients].each do |k, v|
      @order.order_ingredients.create ingredient_id: k.to_i, amount: v.to_i
    end
    debugger
    redirect_to order_path @order
  end

  private

  def order_params
    params.require(:order).permit :preparation, :price
  end
end
