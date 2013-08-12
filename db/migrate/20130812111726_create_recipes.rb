class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.string :prep_time
      t.string :elapsed_time
      t.text :ingredients
      t.text :equipment
      t.text :steps

      t.timestamps
    end
  end
end
