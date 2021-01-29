class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :ensure_user_is_owner
  skip_before_action :ensure_user_is_owner_or_clerk

  def index
    if current_user
      redirect_to menus_path
    else
      render "index"
    end
  end
end
