class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user && current_user.role === "owner"
      render plain: User.all.map { |user| user.to_pleasant_string }.join("\n")
    else
      redirect_to menu_items_path
    end
  end

  def new
    if current_user
      redirect_to menu_items_path
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
