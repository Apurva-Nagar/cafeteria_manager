class Menu < ActiveRecord::Base
  has_many :menu_items, :dependent => :delete_all
  validates :name, presence: true

  def self.active_menu
    find_by active: true
  end

  def self.update_details(id, menu_name, name, price, description)
    menu = Menu.find(id)
    menu.menu_items.all.each_with_index do |item, index|
      updated_item = item.update(
        name: name[index],
        price: price[index],
        description: description[index],
      )

      if !updated_item
        return false
      end
    end
    updated_menu = menu.update(
      name: menu_name,
    )
  end
end
