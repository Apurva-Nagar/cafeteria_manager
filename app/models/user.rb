class User < ApplicationRecord
  has_many :orders, :dependent => :delete_all
  has_secure_password
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }

  def is_owner
    self.role === "owner"
  end

  def get_current_user_orders
    self.orders.order(id: :desc)
  end
end
