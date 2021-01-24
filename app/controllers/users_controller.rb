class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :ensure_user_logged_in

  def index
    render plain: User.all.map { |user| user.to_pleasant_string }.join("\n")
  end

  def new
    render "new"
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
