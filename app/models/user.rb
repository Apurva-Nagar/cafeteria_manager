class User < ApplicationRecord
  has_many :orders
  has_secure_password

  def to_pleasant_string
    "#{id}. | #{name} | #{email} | #{role}"
  end
end
