class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :ensure_user_is_owner, only: [:new, :create]

  def index
    render "index"
  end

  def new
    if current_user
      redirect_to menus_path
    else
      render "new"
    end
  end

  def create
    user = User.new(
      name: params[:name],
      role: "customer",
      email: params[:email],
      password: params[:password],
    )
    if user.save
      session[:current_user_id] = user.id
      redirect_to menu_items_path
    else
      render plain: "ERROR: User creation failed!"
    end
  end
end
