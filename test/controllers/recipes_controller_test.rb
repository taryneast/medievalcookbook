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
        post :create, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: @recipe.name, original_source: @recipe.original_source, prep_time: @recipe.prep_time, steps: @recipe.steps }
      end

      assert_redirected_to recipe_path(assigns(:recipe))
    end

    should "fail to create an invalid recipe" do
      assert_no_difference('Recipe.count') do
        post :create, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: nil, original_source: @recipe.original_source, prep_time: @recipe.prep_time, steps: @recipe.steps }

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
      patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: new_name, original_source: @recipe.original_source, prep_time: @recipe.prep_time, steps: @recipe.steps }
      assert_redirected_to recipe_path(assigns(:recipe))
    end
    should "update our recipe" do
      old_name = @recipe.name
      new_name = old_name + '1234'

      patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: new_name, original_source: @recipe.original_source, prep_time: @recipe.prep_time, steps: @recipe.steps }

      the_recipe = assigns(:recipe)
      assert_not_nil the_recipe
      assert_equal @recipe.id, the_recipe.id, "should have found the one we asked for"

      @recipe.reload
      assert_equal new_name, @recipe.name, "shoudl have persisted the name change"
    end

    should "fail to update a recipe with invalid data" do
      patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: nil, original_source: @recipe.original_source, prep_time: @recipe.prep_time, steps: @recipe.steps }

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
