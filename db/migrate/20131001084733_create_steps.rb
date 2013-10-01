class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :image_url
      t.string :title
      t.text :decription
      t.integer :order

      t.timestamps
    end
  end
end
