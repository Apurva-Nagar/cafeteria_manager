class Cart < ActiveRecord::Base
  has_many :cart_items
  belongs_to :user

  def get_current_user_cart_id
    user_id = @current_user.id
    return Cart.where("user_id = ?", user_id)
  end
end
