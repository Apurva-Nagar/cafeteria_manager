class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    if current_user
      redirect_to menu_items_path
    else
      render "new"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to menu_items_path
    else
      render plain: "Your login attempt was in valid. Please try again."
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
