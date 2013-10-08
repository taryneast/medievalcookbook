class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :recipe_id
      t.string :image_url
      t.string :title
      t.text :description
      t.integer :order

      t.timestamps
    end
    # while I'm still too ignorant to know how to do this only on the up...
    if Recipe.column_names.include?('steps')
      # remove any steps from the existing recipes and create a step object
      # for each
      stepped_recipes = Recipe.where("steps is not NULL")
      say "i found: #{stepped_recipes.count} recipes to migrate"
      if stepped_recipes.present?
        stepped_recipes.all.each do |recipe|
          if recipe.attributes['steps'].present?
            new_step = Step.create(:recipe_id => recipe.id, :description => recipe.attributes['steps'], :order => 1)
          end
        end
      end
    end
    # and now get rid of the old column
    remove_column :recipes, :steps, :text
  end
end
