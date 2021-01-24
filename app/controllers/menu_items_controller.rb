class MenuItemsController < ApplicationController
  def index
    render plain: MenuItem.all.map { |item| item.to_pleasant_string }.join("\n")
  end
end
