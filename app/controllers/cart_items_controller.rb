class CartItemsController < ApplicationController
  def create
    user_cart_id = Cart.get_current_user_cart(@current_user.id).id
    menu_item_info = params[:menu_item_info]

    cart_status = CartItem.add_to_cart(user_cart_id, menu_item_info)

    if cart_status
      redirect_to cart_index_path
    else
      flash[:error] = "Couldn't add items to cart."
      redirect_to menus_path
      return
    end
  end

  def increase
    id = params[:id]
    cart_item = CartItem.find(id)
    cart_item.update(
      menu_item_quantity: cart_item.menu_item_quantity + 1,
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
    else
      cart_item.destroy
    end
    redirect_to request.referrer
  end

  def destroy
    id = params[:id]
    cart_item = CartItem.find(id)
    cart = Cart.find(cart_item.cart_id)
    if cart_item.destroy
      redirect_to cart_index_path
    else
      flash[:error] = "Item could not be deleted from cart."
      redirect_to menus_path
    end
  end
end
