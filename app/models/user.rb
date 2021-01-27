class User < ApplicationRecord
  has_one_attached :avatar
  has_many :orders, :dependent => :delete_all
  has_secure_password
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, on: :update, allow_blank: true

  def is_owner
    self.role === "owner"
  end

  def get_current_user_orders
    self.orders.order(id: :desc)
  end
end
