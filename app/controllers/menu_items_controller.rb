class MenuItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: MenuItem.all.map { |item| item.to_pleasant_string }.join("\n")
  end

  def create
    name = params[:name]
    price = params[:price]
    new_menu_item = MenuItem.new(
      name: name,
      price: price,
    )
    if new_menu_item.save
      render plain: "Menu Item Added"
    else
      render plain: "ERROR: Menu item not added"
    end
  end
end
