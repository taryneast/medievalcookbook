require 'test_helper'

class CookbookControllerTest < ActionController::TestCase
  fixtures :recipes

  context "listing recipes" do
    should "get index" do
      get :index
      assert_response :success
    end
    should "instantiate the recipes" do
      get :index

      arecipes = assigns(:recipes)
      assert_not_nil arecipes, "should have instantiated the recipes"
      assert_equal Recipe.count, arecipes.count, "should have all recipes instantiated"
    end

    context "the view" do
      should "put a recipe table on the page" do
        get :index
        assert_response :success
        assert_select "#columns #main .recipe", Recipe.count, "should have put a listing for each recipe on the page"
      end
    end # context "the view"
  end # context "listing recipes"

end
