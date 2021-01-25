class AddActiveToMenu < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :active, :boolean
  end
end
