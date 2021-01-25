class MenusController < ApplicationController
  skip_before_action :ensure_user_is_owner, only: [:index]

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
      render plain: "ERROR: Menu not added"
    end
  end

  def update
    id = params[:id]
    current_active = Menu.find_by active: "true"
    current_active.active = false
    current_active.save

    update_active_menu = Menu.find(id)
    update_active_menu.active = true
    update_active_menu.save

    redirect_to menus_path
  end
end
