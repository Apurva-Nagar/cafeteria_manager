class Cart < ActiveRecord::Base
  has_many :cart_items
  belongs_to :user

  def self.get_current_user_cart(user_id)
    find_by user_id: user_id
  end

  def self.get_current_user_cart_items(user_id)
    get_current_user_cart(user_id).cart_items
  end

  def self.cartIsEmpty?(user_id)
    get_current_user_cart(user_id).cart_items.length <= 0
  end

  def self.get_cart_total(user_id)
    cart_id = get_current_user_cart(user_id)
    CartItem.where(:cart_id => cart_id).sum("menu_item_quantity * menu_item_price")
  end
end
