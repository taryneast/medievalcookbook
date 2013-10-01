json.array!(@steps) do |step|
  json.extract! step, :image_url, :title, :decription, :order
  json.url step_url(step, format: :json)
end
