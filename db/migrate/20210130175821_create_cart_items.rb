class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.bigint "cart_id"
      t.bigint "menu_item_id"
      t.string "menu_item_name"
      t.decimal "menu_item_price"
      t.integer "menu_item_quantity"

      t.timestamps
    end
  end
end
