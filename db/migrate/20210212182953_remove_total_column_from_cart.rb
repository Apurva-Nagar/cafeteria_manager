class RemoveTotalColumnFromCart < ActiveRecord::Migration[6.1]
  def change
    remove_column :carts, :total
  end
end
