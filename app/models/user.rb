class User < ApplicationRecord
  has_many :orders
  has_secure_password

  def is_owner
    self.role === "owner"
  end

  def get_current_user_orders
    self.orders.order(id: :desc)
  end
end
