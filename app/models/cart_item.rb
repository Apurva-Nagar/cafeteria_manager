class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :menu_item

  def self.add_to_cart(user_cart_id, menu_item_info, cart_total)
    menu_item_info.each do |item|
      id = item["info"]["menu_item_id"] ? item["info"]["menu_item_id"] : nil
      if id
        cart_item = CartItem.new(
          cart_id: user_cart_id,
          menu_item_id: id,
          menu_item_name: MenuItem.find(id).name,
          menu_item_price: MenuItem.find(id).price,
          menu_item_quantity: item["info"]["quantity"],
        )
        cart_total += (cart_item.menu_item_price * cart_item.menu_item_quantity)
        if !cart_item.save
          return false
        end
      end
    end

    Cart.find(user_cart_id).update(
      total: cart_total,
    )
  end
end
