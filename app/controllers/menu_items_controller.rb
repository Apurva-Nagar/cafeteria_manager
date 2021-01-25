class MenuItemsController < ApplicationController
  def index
    render "index"
  end

  def create
    name = params[:name]
    price = params[:price]
    menu_id = params[:menu_id]
    description = params[:description]
    new_menu_item = MenuItem.new(
      name: name,
      price: price,
      menu_id: menu_id,
      description: description,
    )
    if new_menu_item.save
      redirect_to menu_items_path
    else
      render plain: "ERROR: Menu item not added"
    end
  end
end
