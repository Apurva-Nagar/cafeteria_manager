class MenuItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render "index"
  end

  def create
    name = params[:name]
    price = params[:price]
    new_menu_item = MenuItem.new(
      name: name,
      price: price,
    )
    if new_menu_item.save
      redirect_to menu_items_path
    else
      render plain: "ERROR: Menu item not added"
    end
  end
end
