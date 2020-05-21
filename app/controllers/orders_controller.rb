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
    @order = Order.preload(:ingredients).find_by(id: params[:id])
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
    (params.require(:order).permit(ingredients: {})[:ingredients] || {}).each do |k, v|
      @order.order_ingredients.create ingredient_id: k.to_i, amount: v.to_i
    end
    redirect_to order_path @order
  end

  def edit
    @order = Order.preload(:ingredients).find_by(id: params[:id])
  end

  def update
    p      = params.require(:order).permit(:state, :price)
    @order = Order.preload(:ingredients).find_by(id: params[:id])
    @order.update p
    @order  = Order.preload(:ingredients).find_by(id: params[:id])
    @orders = @current_user.orders.preload(:ingredients)
    ActionCable.server.broadcast "user_#{@order.user_id}", body: {
        general:  render_to_string(partial: 'layouts/p1'),
        specific: render_to_string(partial: 'layouts/p2'),
        id:       params[:id],
    }
    redirect_to edit_order_path @order
  end

  private

  def order_params
    params.require(:order).permit :preparation, :price
  end
end
