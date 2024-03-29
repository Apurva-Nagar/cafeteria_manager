class OrdersController < ApplicationController
  before_action :ensure_user_is_owner, only: [:get_report, :show_report]
  before_action :ensure_user_is_owner_or_clerk, only: [:update]

  def index
    render "index"
  end

  def create
    date = Date.today
    user_id = current_user.id
    cart = Cart.find_by user_id: user_id

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

  def get_report
    render "report"
  end

  def show_report
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    start_date_obj = params[:start_date].to_date.beginning_of_day
    end_date_obj = params[:end_date].to_date.end_of_day
    @report_orders = Order.get_report_orders(start_date_obj, end_date_obj)
    @walkin_orders = Order.get_walkin_orders(@report_orders)
    @max_item_ordered = Order.get_max_ordered_item(@report_orders)
    @min_item_ordered = Order.get_min_ordered_item(@report_orders)
    @average_order_amount = Order.get_average_order_amount(@report_orders)
    @sum_orders_total = Order.get_sum_orders_total(@report_orders)
    render "report"
  end
end
