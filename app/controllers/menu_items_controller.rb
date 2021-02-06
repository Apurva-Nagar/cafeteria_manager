class MenuItemsController < ApplicationController
  before_action :ensure_user_is_owner

  def index
    render "index"
  end

  def create
    name = params[:name]
    price = params[:price]
    menu_id = params[:menu_id]
    description = params[:description]
    picture = params[:picture]

    new_menu_item = MenuItem.new(
      name: name,
      price: price,
      menu_id: menu_id,
      description: description,
      picture: picture,
    )
    if new_menu_item.save
      redirect_to menu_items_path
    else
      flash[:error] = new_menu_item.errors.full_messages.join(", ")
      redirect_to menu_items_path
    end
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
    render "edit"
  end

  def update
    id = params[:id]
    name = params[:name]
    price = params[:price]
    menu_id = params[:menu_id]
    description = params[:description]
    picture = params[:picture]

    @menu_item = MenuItem.find(id)

    if picture
      updated_menu_item = @menu_item.update(
        name: name,
        price: price,
        menu_id: menu_id,
        description: description,
        picture: picture,
      )
    else
      updated_menu_item = @menu_item.update(
        name: name,
        price: price,
        menu_id: menu_id,
        description: description,
      )
    end

    if updated_menu_item
      redirect_to menu_items_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def destroy
    id = params[:id]
    item = MenuItem.find(id)
    item.destroy
    redirect_to menu_items_path
  end
end
