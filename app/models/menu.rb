class Menu < ActiveRecord::Base
  has_many :menu_items, :dependent => :delete_all
  validates :name, presence: true

  def self.active_menu
    Menu.find_by active: true
  end
end
