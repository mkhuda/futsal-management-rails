class CreateFutsalPlaces < ActiveRecord::Migration
  def change
    create_table :futsal_places do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
