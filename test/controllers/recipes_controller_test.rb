require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: @recipe.name, original_source: @recipe.original_source, prep_time: @recipe.prep_time, steps: @recipe.steps }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, id: @recipe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recipe
    assert_response :success
  end

  test "should update recipe" do
    patch :update, id: @recipe, recipe: { description: @recipe.description, elapsed_time: @recipe.elapsed_time, equipment: @recipe.equipment, ingredients: @recipe.ingredients, main_image_url: @recipe.main_image_url, name: @recipe.name, original_source: @recipe.original_source, prep_time: @recipe.prep_time, steps: @recipe.steps }
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to recipes_path
  end
end