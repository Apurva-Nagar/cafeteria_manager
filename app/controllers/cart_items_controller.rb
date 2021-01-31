class CartItemsController < ApplicationController
  def create
    user_cart_id = Cart.get_current_user_cart_id
    menu_item_ids = params[:menu_item_ids]
    quantities = params[:quantities]

    cart_total = 0.0

    menu_item_ids.each_with_index do |id, index|
      cart_item = CartItem.new(
        cart_id: user_cart_id,
        menu_item_id: id,
        menu_item_name: MenuItem.find(id).name,
        menu_item_price: MenuItem.find(id).price,
        menu_item_quantity: quantities[index],
      )
      cart_total += cart_item.menu_item_price
    end

    Cart.find(user_cart_id).update(
      total: cart_total,
    )
  end
end
