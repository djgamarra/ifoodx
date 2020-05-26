class OrdersController < ApplicationController
  before_action :require_logged_in

  def index
    @orders = if @current_user.is_admin
                Order.preload(:ingredients).admin_order
              else
                @current_user.orders.preload(:ingredients)
              end
    @ingredients = Ingredient.all
    ing = {}
    @ingredients.each { |i| ing[i.id] = i }
    gon.push ingredients: ing
  end

  def show
    @order = Order.includes(:ingredients, messages: :user).find_by(id: params[:id])
  end

  def new
    @order = Order.new
    @ingredients = Ingredient.all
    ing = {}
    @ingredients.each { |i| ing[i.id] = i }
    gon.push ingredients: ing
  end

  def create
    p = order_params
    p[:user] = @current_user
    p[:minimum_price] = p[:price]
    @order = Order.create p
    (params.require(:order).permit(ingredients: {})[:ingredients] || {}).each do |k, v|
      @order.order_ingredients.create ingredient_id: k.to_i, amount: v.to_i
    end
    # if @current_user.is_admin
    @orders = Order.preload(:ingredients).admin_order
    ActionCable.server.broadcast "user", body: {
      general: render_to_string(partial: 'layouts/p1', locals: { admin: true }),
      specific: render_to_string(partial: 'layouts/p2'),
      id: params[:id],
    }
    @orders = Order.where(user_id: @order.user_id).preload(:ingredients).all
    ActionCable.server.broadcast "user_#{@order.user_id}", body: {
      general: render_to_string(partial: 'layouts/p1', locals: { admin: false }),
      specific: render_to_string(partial: 'layouts/p2'),
      id: params[:id],
    }
    # else
    #   @orders = Order.preload(:ingredients).admin_order
    #   ActionCable.server.broadcast "user", body: {
    #     general: render_to_string(partial: 'layouts/p1', locals: { admin: true }),
    #     specific: render_to_string(partial: 'layouts/p2'),
    #     id: params[:id],
    #   }
    #   @current_user.orders.preload(:ingredients)
    #   ActionCable.server.broadcast "user_#{@current_user.id}", body: {
    #     general: render_to_string(partial: 'layouts/p1', locals: { admin: false }),
    #     specific: render_to_string(partial: 'layouts/p2'),
    #     id: params[:id],
    #   }
    # end
    redirect_to order_path @order
  end

  def edit
    @order = Order.preload(:ingredients, messages: :user).find_by(id: params[:id])
  end

  def update
    p = params.require(:order).permit(:state, :price)
    @order = Order.preload(:ingredients).find_by(id: params[:id])
    @order.update p
    @order = Order.preload(:ingredients).find_by(id: params[:id])
    if @current_user.is_admin
      @orders = Order.preload(:ingredients).all
      ActionCable.server.broadcast "user", body: {
        general: render_to_string(partial: 'layouts/p1', locals: { admin: true }),
        specific: render_to_string(partial: 'layouts/p2'),
        id: params[:id],
      }
      @orders = Order.where(user_id: @order.user_id).preload(:ingredients).all
      ActionCable.server.broadcast "user_#{@order.user_id}", body: {
        general: render_to_string(partial: 'layouts/p1', locals: { admin: false }),
        specific: render_to_string(partial: 'layouts/p2'),
        id: params[:id],
      }
    else
      @orders = Order.preload(:ingredients).all
      ActionCable.server.broadcast "user", body: {
        general: render_to_string(partial: 'layouts/p1', locals: { admin: true }),
        specific: render_to_string(partial: 'layouts/p2'),
        id: params[:id],
      }
      @current_user.orders.preload(:ingredients)
      ActionCable.server.broadcast "user_#{@current_user.id}", body: {
        general: render_to_string(partial: 'layouts/p1', locals: { admin: false }),
        specific: render_to_string(partial: 'layouts/p2'),
        id: params[:id],
      }
    end
    redirect_to edit_order_path @order
  end

  def send_message
    @order = Order.preload(:ingredients, messages: :user).find_by(id: message_params[:order_id])
    @order.messages.create message_params
    ActionCable.server.broadcast "user_#{@order.user_id}", body: {
      chat: render_to_string(partial: 'layouts/chat'),
      notice: @current_user.is_admin,
      order_id: @order.id
    }
    ActionCable.server.broadcast "user", body: {
      chat: render_to_string(partial: 'layouts/chat'),
      notice: !@current_user.is_admin,
      order_id: @order.id
    }
  end

  private

  def order_params
    params.require(:order).permit :preparation, :price
  end

  def message_params
    p = params.require(:message).permit :text, :order_id
    p[:user_id] = @current_user.id
    p
  end
end
