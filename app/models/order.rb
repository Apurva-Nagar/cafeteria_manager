class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :delete_all
  belongs_to :user

  def get_customer_name
    User.find(self.user_id).name
  end

  def get_status
    if self.delivered
      "Delivered"
    else
      "Not Delivered"
    end
  end

  def self.create_order(date, user_id, cart)
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
          return false
        end
      end
      cart.cart_items.delete_all
      cart.update(
        total: 0.0,
      )
    else
      return false
    end
  end

  def self.get_report_orders(start_date, end_date)
    where(:created_at => start_date..end_date)
  end

  def self.get_walkin_orders(report_orders)
    count = 0
    report_orders.each do |order|
      if order.user_id == 4
        count += 1
      end
    end
    count
  end

  def self.get_max_ordered_item(report_orders)
    max_count = 0
    max_item_name = nil
    report_orders.each do |order|
      count = 0
      item_name = nil
      order.order_items.all.each do |item|
        item_name = item.menu_item_name
        count += item.quantity
      end
      if max_count < count
        max_count = count
        max_item_name = item_name
      end
    end
    max_item_name
  end
end
