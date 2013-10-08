require 'test_helper'

class StepTest < ActiveSupport::TestCase
  context "creating a step" do
    should belong_to(:recipe)

    should validate_presence_of(:recipe)
  end

end
