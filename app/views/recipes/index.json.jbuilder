json.array!(@recipes) do |recipe|
  json.extract! recipe, :name, :original_source, :description, :prep_time, :elapsed_time, :ingredients, :equipment, :steps
  json.url recipe_url(recipe, format: :json)
end
