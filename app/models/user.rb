class User < ApplicationRecord
  has_many :orders
  has_secure_password

  def is_owner
    self.role === "owner"
  end
end
