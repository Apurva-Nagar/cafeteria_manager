class Menu < ActiveRecord::Base
  has_many :menu_items

  def self.active_menu
    Menu.find_by active: true
  end
end
