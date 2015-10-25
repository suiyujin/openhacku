json.categories do
  json.array! @categories do |category|
    json.extract! category, :id, :category
  end
end
