class MenusController < ApplicationController
  skip_before_action :ensure_user_is_owner, only: [:index]

  def index
    render "index"
  end

  def create
    name = params[:name]
    new_menu = Menu.new(
      name: name,
    )
    if new_menu.save
      redirect_to menu_items_path
    else
      render plain: "ERROR: Menu not added"
    end
  end
end
