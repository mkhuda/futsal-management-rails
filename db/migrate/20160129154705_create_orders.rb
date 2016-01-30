class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :harga, precision: 10, scale: 0

      t.timestamps null: false
    end
  end
end
