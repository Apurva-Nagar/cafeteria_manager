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

  def updateDetails
    id = params[:id]
    name = params[:name]

    menu = Menu.find(id)

    if menu.update(
      name: name,
    )
      redirect_to menus_path
    else
      redirect_to request.referrer
    end
  end
end
