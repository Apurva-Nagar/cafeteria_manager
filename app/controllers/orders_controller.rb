class OrdersController < ApplicationController
  skip_before_action :ensure_user_is_owner
  skip_before_action :ensure_user_is_owner_or_clerk, only: [:create, :index]

  def index
    render "index"
  end

  def create
    date = Date.today
    user_id = current_user.id
    menu_item_ids = params[:menu_item_ids]

    if @current_user.is_owner || @current_user.is_clerk
      user_id = 4
    end

    if !menu_item_ids
      flash[:error] = "Please select at least one item to place an order."
      redirect_to menus_path
      return
    end

    new_order = Order.new(
      date: date,
      user_id: user_id,
      delivered: false,
    )

    order_total = 0.0

    if new_order.save
      menu_item_ids.each do |id|
        order_item = OrderItem.new(
          order_id: new_order.id,
          menu_item_id: id,
          menu_item_name: MenuItem.find(id).name,
          menu_item_price: MenuItem.find(id).price,
        )
        order_total += order_item.menu_item_price
        if !order_item.save
          flash[:error] = "Item could not be added to order."
        end
      end
      if new_order.update(
        total: order_total,
      )
        redirect_to orders_path
      else
        flash[:error] = "Order could not be placed."
        redirect_to menus_path
      end
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
