class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :delete_all
  belongs_to :user

  def get_customer_name
    User.find(self.user_id).name
  end

  def get_status
    if self.delivered
      "Delivered"
    else
      "Not Delivered"
    end
  end
end
