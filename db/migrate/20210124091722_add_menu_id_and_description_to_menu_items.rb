class AddMenuIdAndDescriptionToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :menu_id, :bigint
    add_column :menu_items, :description, :text
  end
end
