class CreateUserMembers < ActiveRecord::Migration
  def change
    create_table :user_members do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
