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
end
