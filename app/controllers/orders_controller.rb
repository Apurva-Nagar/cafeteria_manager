class OrdersController < ApplicationController
  before_action :ensure_user_is_owner_or_clerk, only: [:update]

  def index
    render "index"
  end

  def create
    date = Date.today
    user_id = current_user.id
    cart = Cart.find_by user_id: user_id

    if @current_user.is_owner || @current_user.is_clerk
      user_id = 4
    end

    order_creation_status = Order.create_order(date, user_id, cart)

    if order_creation_status
      redirect_to orders_path
    else
      flash[:error] = "Order creation failed. Please try later."
      redirect_to menus_path
    end
  end

  def update
    id = params[:id]
    order = Order.find(id)
    order.delivered = true
    if order.save
      flash[:success] = "Order with ID #{id} marked as delivered."
      redirect_to orders_path
    else
      flash[:error] = "Order status could not be updated."
      redirect_to orders_path
    end
  end
end
