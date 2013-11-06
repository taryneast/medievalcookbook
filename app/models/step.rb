class Step < ActiveRecord::Base
  belongs_to :recipe, touch: true
end
