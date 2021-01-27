class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:new, :create]
  skip_before_action :ensure_user_is_owner, only: [:new, :create, :edit, :update]

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
      avatar: params[:avatar],
    )
    if user.save
      session[:current_user_id] = user.id
      redirect_to menu_items_path
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

    edit_user = User.find(id)

    if edit_user.update(
      name: name,
      email: email,
      avatar: avatar,
    )
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
