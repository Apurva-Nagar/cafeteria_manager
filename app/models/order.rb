class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :delete_all
  belongs_to :user

  def get_customer_name
    user = User.find(self.user_id)
    if user.is_owner || user.is_clerk
      return "Walk-in-customer"
    end
    user.name
  end

  def get_status
    if self.delivered
      "Delivered"
    else
      "Not Delivered"
    end
  end

  def self.create_order(date, user_id, cart)
    ActiveRecord::Base.transaction do
      new_order = Order.create!(
        date: date,
        user_id: user_id,
        delivered: false,
        total: Cart.get_cart_total(user_id),
      )
      cart.cart_items.each do |item|
        OrderItem.create!(
          order_id: new_order.id,
          menu_item_id: item.menu_item_id,
          menu_item_name: item.menu_item_name,
          menu_item_price: item.menu_item_price,
          quantity: item.menu_item_quantity,
        )
      end
      cart.cart_items.delete_all
    end
  rescue ActiveRecord::RecordInvalid => exception
    false
  end

  def self.get_report_orders(start_date, end_date)
    where(:created_at => start_date..end_date)
  end

  def self.get_walkin_orders(report_orders)
    report_orders.where(user_id: 4).count()
  end

  def self.get_max_ordered_item(report_orders)
    item_name_qty = OrderItem.where(:order_id => report_orders.all.ids).group(:menu_item_name).sum(:quantity)
    item_name_qty.max_by { |k, v| v }
  end

  def self.get_min_ordered_item(report_orders)
    item_name_qty = OrderItem.where(:order_id => report_orders.all.ids).group(:menu_item_name).sum(:quantity)
    item_name_qty.min_by { |k, v| v }
  end

  def self.get_average_order_amount(report_orders)
    report_orders.average(:total)
  end

  def self.get_sum_orders_total(report_orders)
    report_orders.sum(:total)
  end
end
