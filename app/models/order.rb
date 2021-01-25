class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  def get_customer_name
    User.find(self.user_id).name
  end
end
