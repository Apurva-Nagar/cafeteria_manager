class Menu < ActiveRecord::Base
  has_many :menu_items

  def to_pleasant_string
    "#{id}. | #{name}"
  end
end
