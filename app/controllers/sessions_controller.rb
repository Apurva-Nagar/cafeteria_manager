class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    render "new"
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
    render plain: "You are now logged out"
  end
end
