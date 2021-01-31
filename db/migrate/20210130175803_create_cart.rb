class CreateCart < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.bigint :user_id
      t.decimal :total

      t.timestamps
    end
  end
end
