class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  protected

  def ensure_user_is_owner_or_clerk
    unless current_user && (current_user.is_owner? || current_user.is_clerk?)
      redirect_to root_path
    end
  end

  def ensure_user_is_owner
    unless current_user && current_user.is_owner?
      redirect_to root_path
    end
  end

  def ensure_user_logged_in
    unless current_user
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end
end
