class CreateUsages < ActiveRecord::Migration
  def change
    create_table :usages do |t|
	
	  t.belongs_to :field, index: true
	  t.belongs_to :team_member, index: true
	  t.datetime :start_date
	  t.datetime :finish_date
	  t.decimal :harga

      t.timestamps null: false
    end
  end
end
