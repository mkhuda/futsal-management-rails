class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|

      t.timestamps null: false
    end
  end
end
