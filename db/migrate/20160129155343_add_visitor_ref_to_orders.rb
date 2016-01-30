class AddVisitorRefToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :visitor, index: true, foreign_key: true
  end
end
