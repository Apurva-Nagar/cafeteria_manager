class CartController < ApplicationController
  def index
    # @user_cart = Cart.find_by user_id: @current_user.id
    render "index"
  end
end
