class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :ensure_user_is_owner

  def new
    if current_user
      redirect_to menus_path
    else
      render "new"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      if user.role === "owner"
        redirect_to orders_path
      else
        redirect_to menus_path
      end
    else
      flash[:error] = "Login attempt failed. Invalid credentials."
      redirect_to new_session_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    redirect_to "/"
  end
end
