class MenusController < ApplicationController
  skip_before_action :ensure_user_is_owner, only: [:index]
  skip_before_action :ensure_user_is_owner_or_clerk, only: [:index]

  def index
    render "index"
  end

  def create
    name = params[:name]
    new_menu = Menu.new(
      name: name,
      active: false,
    )
    if new_menu.save
      redirect_to menu_items_path
    else
      flash[:error] = new_menu.errors.full_messages.join(", ")
      redirect_to menus_path
    end
  end

  def edit
    @menu = Menu.find(params[:id])
    render "edit"
  end

  def update
    id = params[:id]
    current_active = Menu.find_by active: "true"

    if current_active
      current_active.update(
        active: false,
      )
    end

    update_active_menu = Menu.find(id)
    update_active_menu.update(
      active: true,
    )
    redirect_to menus_path
  end

  def update_details
    id = params[:id]
    menu_name = params[:menu_name]
    name = params[:name]
    price = params[:price]
    description = params[:description]

    menu = Menu.find(id)

    menu.menu_items.all.each_with_index do |item, index|
      updated_item = item.update(
        name: name[index],
        price: price[index],
        description: description[index],
      )

      if !updated_item
        flash[:error] = "Couldn't update menu item information."
        redirect_to request.referrer
        return
      end
    end

    updated_menu = menu.update(
      name: menu_name,
    )

    if updated_menu
      redirect_to menus_path
    else
      flash[:error] = "Couldn't update menu information"
      redirect_to request.referrer
    end
  end

  def destroy
    id = params[:id]
    if Menu.find(id).destroy
      redirect_to menus_path
    else
      flash[:error] = "Menu could not be deleted."
      redirect_to menus_path
    end
  end
end
