class CartController < ApplicationController
  skip_before_action :ensure_user_is_owner
  skip_before_action :ensure_user_is_owner_or_clerk

  def index
    # @user_cart = Cart.find_by user_id: @current_user.id
    render "index"
  end
end
