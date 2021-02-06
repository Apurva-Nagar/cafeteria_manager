class CartItemsController < ApplicationController
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

  def increase
    id = params[:id]
    cart_item = CartItem.find(id)
    cart_item.update(
      menu_item_quantity: cart_item.menu_item_quantity + 1,
    )
    cart = Cart.find(cart_item.cart_id)
    cart.update(
      total: cart.total + cart_item.menu_item_price,
    )
    redirect_to request.referrer
  end

  def decrease
    id = params[:id]
    cart_item = CartItem.find(id)
    cart = Cart.find(cart_item.cart_id)
    if cart_item.menu_item_quantity > 1
      cart_item.update(
        menu_item_quantity: cart_item.menu_item_quantity - 1,
      )
      cart.update(
        total: cart.total - cart_item.menu_item_price,
      )
    else
      cart.update(
        total: cart.total - cart_item.menu_item_price,
      )
      cart_item.destroy
    end
    redirect_to request.referrer
  end

  def destroy
    id = params[:id]
    cart_item = CartItem.find(id)
    cart = Cart.find(cart_item.cart_id)
    updated_cart_price = cart.total - (cart_item.menu_item_price * cart_item.menu_item_quantity)
    if cart_item.destroy
      cart.update(
        total: updated_cart_price,
      )
      redirect_to cart_index_path
    else
      flash[:error] = "Item could not be deleted from cart."
      redirect_to menus_path
    end
  end
end
