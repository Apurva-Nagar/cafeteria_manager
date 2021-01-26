class OrdersController < ApplicationController
  skip_before_action :ensure_user_is_owner, only: [:create, :index]

  def index
    render "index"
  end

  def create
    date = Date.today
    user_id = current_user.id
    menu_item_ids = params[:menu_item_ids]

    if User.find(user_id).role === "owner"
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

    if new_order.save
      menu_item_ids.each do |id|
        order_item = OrderItem.new(
          order_id: new_order.id,
          menu_item_id: id,
          menu_item_name: MenuItem.find(id).name,
          menu_item_price: MenuItem.find(id).price,
        )
        if !order_item.save
          flash[:error] = "Item could not be added to order."
        end
      end
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
      redirect_to orders_path
    else
      flash[:error] = "Order status could not be updated."
      redirect_to orders_path
    end
  end
end
