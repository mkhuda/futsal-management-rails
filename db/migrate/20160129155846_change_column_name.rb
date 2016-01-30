class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :orders, :harga, :biaya
  end
end
