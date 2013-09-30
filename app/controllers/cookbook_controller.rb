class CookbookController < ApplicationController
  def index
    @recipes = Recipe.order(:name)
  end
end
