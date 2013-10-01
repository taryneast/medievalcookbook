class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :recipe_id
      t.string :image_url
      t.string :title
      t.text :decription
      t.integer :order

      t.timestamps
    end
  end
end
