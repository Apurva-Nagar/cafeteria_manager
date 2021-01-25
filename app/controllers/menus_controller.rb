class MenusController < ApplicationController
  def index
    render "index"
  end

  def create
    name = params[:name]
    new_menu = Menu.new(
      name: name,
    )
    if new_menu.save
      redirect_to menus_path
    else
      render plain: "ERROR: Menu not added"
    end
  end
end
