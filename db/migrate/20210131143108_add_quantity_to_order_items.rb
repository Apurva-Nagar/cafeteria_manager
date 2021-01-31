class AddQuantityToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :quantity, :integer
  end
end
