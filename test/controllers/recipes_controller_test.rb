require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
  end

  context "listing recipes" do
    should "get index" do
      get :index
      assert_response :success
    end
    should "instantiate the recipes" do
      get :index

      arecipes = assigns(:recipes)
      assert_not_nil recipes, "should have instantiated the recipes"
      assert_equal Recipe.count, arecipes.count, "should have all recipes instantiated"
      assert arecipes.include?(@recipe), "should have put all the recipes in there, including the one we expect"
    end
    should "put a recipe table on the page" do
      get :index
      assert_response :success
      assert_select "table tr", Recipe.count, "should have put a listing for each recipe on the page"
    end
  end # context "listing recipes"

  context "creating recipes" do
    should "get new" do
      get :new
      assert_response :success
    end
    should "instantiate a new recipe" do
      get :new
      the_recipe = assigns(:recipe)
      assert_not_nil the_recipe
      assert the_recipe.is_a?(Recipe)
      assert the_recipe.new_record?, "should be a new instance"
    end

    should "create a valid recipe" do
      assert_difference('Recipe.count') do
        post :create, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: @recipe.name, original_source: @recipe.original_source, prep_time: @recipe.prep_time }
      end

      assert_redirected_to recipe_path(assigns(:recipe))
    end

    should "create a recipe with embedded steps" do
      step = steps(:one)
      assert_difference('Recipe.count') do
        assert_difference('Step.count') do
          post :create, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: @recipe.name, original_source: @recipe.original_source, prep_time: @recipe.prep_time, 
            steps_attributes: { '0' => { description: step.description, image_url: step.image_url, order: step.order, title: step.title } } }
        end
      end


      the_recipe = assigns(:recipe)
      assert_not_nil the_recipe
      assert the_recipe.steps.present?

      assert_redirected_to recipe_path(assigns(:recipe))
    end

    should "fail to create an invalid recipe" do
      assert_no_difference('Recipe.count') do
        post :create, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: nil, original_source: @recipe.original_source, prep_time: @recipe.prep_time }

      end

      assert_response :success
      assert render_template('new'), "should re-display the 'new' template"
      assert assigns(:recipe).errors[:name].present?, "should have put the errors on the recipe"
    end
  end # context "creating recipes"

  test "should show recipe" do
    get :show, id: @recipe
    assert_response :success
  end

  context "editing and exsting recipe" do
    should "get edit" do
      get :edit, id: @recipe
      assert_response :success
    end
    should "find our recipe" do
      get :edit, id: @recipe

      the_recipe = assigns(:recipe)
      assert_not_nil the_recipe
      assert_equal @recipe.id, the_recipe.id, "shoudl have found the one we asked for"
    end


    should "update a recipe with valid data" do
      old_name = @recipe.name
      new_name = old_name + '1234'
      patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: new_name, original_source: @recipe.original_source, prep_time: @recipe.prep_time }
      assert_redirected_to recipe_path(assigns(:recipe))
    end
    should "update our recipe" do
      old_name = @recipe.name
      new_name = old_name + '1234'

      patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: new_name, original_source: @recipe.original_source, prep_time: @recipe.prep_time }

      the_recipe = assigns(:recipe)
      assert_not_nil the_recipe
      assert_equal @recipe.id, the_recipe.id, "should have found the one we asked for"

      @recipe.reload
      assert_equal new_name, @recipe.name, "should have persisted the name change"
    end

    should "update embedded steps in a recipe" do
      step = steps(:two)

      old_steps = @recipe.steps
      assert old_steps.present?, "should have one step already from fixtures"
      old_step = old_steps.first
      old_name = old_step.title
      new_name = old_name + "abc"

      # post an update that updates the name of the existing step, and also adds a new step
      assert_difference('Step.count') do
        patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: @recipe.name, original_source: @recipe.original_source, prep_time: @recipe.prep_time, 
           steps_attributes: { '0' => {id: old_step.id, description: old_step.description, image_url: old_step.image_url, order: old_step.order, title: new_name}, 
                               '1' => {description: step.description, image_url: step.image_url, order: step.order, title: step.title}} }
      end

      the_recipe = assigns(:recipe)
      assert_not_nil the_recipe
      assert_equal @recipe.id, the_recipe.id, "should have found the one we asked for"

      @recipe.reload
      new_steps = @recipe.steps

      assert new_steps.present?, "should have some kind of steps now"
      assert_equal 2, new_steps.count, "should have 2 steps now"

      assert new_steps.map(&:title).include?(new_name), "should have a step with the newly updated name"
      assert !new_steps.map(&:title).include?(old_name), "should *NOT* have a step with the old name"

      assert new_steps.map(&:title).include?(step.title), "should have a step with the new step's title"
    end

    should "fail to update a recipe with invalid data" do
      patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: nil, original_source: @recipe.original_source, prep_time: @recipe.prep_time }

      assert_response :success
      assert render_template('edit'), "should re-display the 'edit' template"
      assert assigns(:recipe).errors[:name].present?, "should have put the errors on the recipe"
    end
  end # context "editing and exsting recipe"

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to recipes_path
  end
end
