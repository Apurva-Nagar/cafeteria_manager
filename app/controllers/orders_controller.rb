class OrdersController < ApplicationController
  def index
    render "index"
  end

  def create
    date = Date.today
    user_id = current_user.id
    menu_item_ids = params[:menu_item_ids]

    current_order = Order.new(
      date: date,
      user_id: user_id,
      delivered: false,
    )

    if current_order.save
      menu_item_ids.each do |id|
        order_item = OrderItem.new(
          order_id: current_order.id,
          menu_item_id: id,
          menu_item_name: MenuItem.find(id).name,
          menu_item_price: MenuItem.find(id).price,
        )
        if !order_item.save
          render plain: "some error occured!"
        end
      end
    else
      render plain: "some error occured!"
    end
    redirect_to orders_path
  end
end
