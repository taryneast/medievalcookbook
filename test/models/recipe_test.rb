require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  context "creating a recipe" do

    should have_many(:steps)

    should validate_presence_of(:name)
    should validate_presence_of(:ingredients)

    ['lalala.jpg','lalala.jpeg','something.gif','coolthing.png'].each do |good_url|
      should allow_value(good_url).for(:main_image_url).with_message('must be a gif, jpg or png')
    end
    ['akywrgfgr3gb','jpg','badthing.jpg.pdf','evil.png/more'].each do |bad_url|
      should_not allow_value(bad_url).for(:main_image_url).with_message('must be a gif, jpg or png')
    end
  end # context "creating a recipe"

  context "instance methods" do
    setup do
      @recipe = Recipe.new
    end
    context "display_time" do
      should "exist" do
        assert @recipe.respond_to?(:display_time)
      end
      should "return nothing if neither time-column is present" do
        @recipe.expects(:elapsed_time).returns(nil)
        @recipe.expects(:prep_time).returns(nil)
        assert_nil @recipe.display_time
      end
      should "return elapsed time only if it's the only one present" do
        etime = 42
        @recipe.expects(:elapsed_time).at_least_once.returns(etime)
        @recipe.expects(:prep_time).at_least_once.returns(nil)
        assert_equal "(#{etime})", @recipe.display_time
      end
      should "return prep time only if it's the only one present" do
        ptime = 23
        @recipe.expects(:elapsed_time).at_least_once.returns(nil)
        @recipe.expects(:prep_time).at_least_once.returns(ptime)
        assert_equal "(#{ptime})", @recipe.display_time
      end
      should "return a combined string if both present" do
        etime,ptime = 42,23
        @recipe.expects(:elapsed_time).at_least_once.returns(etime)
        @recipe.expects(:prep_time).at_least_once.returns(ptime)
        assert_equal "(#{ptime}->#{etime})", @recipe.display_time
      end
    end
  end # context "instance methods"
end
