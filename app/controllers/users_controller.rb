class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:new, :create]
  before_action :ensure_user_is_owner, only: [:index, :destroy]

  def index
    render "index"
  end

  def new
    if current_user && !current_user.is_owner
      redirect_to menus_path
    else
      render "new"
    end
  end

  def create
    role = current_user && current_user.is_owner ? "billing clerk" : "customer"

    user = User.new(
      name: params[:name],
      role: role,
      email: params[:email],
      password: params[:password],
      avatar: params[:avatar],
    )
    if user.save
      cart_user_id = user.id
      user_cart = Cart.new(
        user_id: cart_user_id,
      )
      if user_cart.save
        if user.role != "billing clerk"
          session[:current_user_id] = user.id
          redirect_to menu_items_path
        else
          redirect_to users_path
        end
      end
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def edit
    render "edit"
  end

  def update
    id = params[:id]
    name = params[:name]
    email = params[:email]
    avatar = params[:avatar]

    user = User.find(id)

    if avatar
      updated_user = user.update(
        name: name,
        email: email,
        avatar: avatar,
      )
    else
      updated_user = user.update(
        name: name,
        email: email,
      )
    end

    if updated_user
      redirect_to menus_path
    else
      flash[:error] = "Couldn't updated user details."
      redirect_to request.referrer
    end
  end

  def destroy
    id = params[:id]
    if User.find(id).destroy
      redirect_to users_path
    else
      flash[:error] = "User account could not be deleted."
      redirect_to users_path
    end
  end
end
