require 'test_helper'

class StepTest < ActiveSupport::TestCase
  context "creating a step" do
    should belong_to(:recipe)
  end
end
