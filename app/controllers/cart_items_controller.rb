class CartItemsController < ApplicationController
  skip_before_action :ensure_user_is_owner
  skip_before_action :ensure_user_is_owner_or_clerk

  def create
    user_cart_id = Cart.get_current_user_cart(@current_user.id).id
    menu_item_info = params[:menu_item_info]
    cart_total = Cart.get_current_user_cart(@current_user.id).total

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
          flash[:error] = "Couldn't add item to cart."
          redirect_to menus_path
          return
        end
      end
    end

    Cart.find(user_cart_id).update(
      total: cart_total,
    )

    redirect_to cart_index_path
  end
end
