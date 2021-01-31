class OrdersController < ApplicationController
  skip_before_action :ensure_user_is_owner
  skip_before_action :ensure_user_is_owner_or_clerk, only: [:create, :index]

  def index
    render "index"
  end

  def create
    date = Date.today
    user_id = current_user.id

    if @current_user.is_owner || @current_user.is_clerk
      user_id = 4
    end

    cart = Cart.find_by user_id: user_id

    new_order = Order.new(
      date: date,
      user_id: user_id,
      delivered: false,
      total: cart.total,
    )

    if new_order.save
      cart.cart_items.each do |item|
        order_item = OrderItem.new(
          order_id: new_order.id,
          menu_item_id: item.menu_item_id,
          menu_item_name: item.menu_item_name,
          menu_item_price: item.menu_item_price,
          quantity: item.menu_item_quantity,
        )
        if !order_item.save
          flash[:error] = "Item could not be added to order."
        end
      end
      cart.cart_items.delete_all
      cart.update(
        total: 0.0,
      )
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
