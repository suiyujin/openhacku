json.keywords do
  json.array! @keywords do |keyword|
    json.extract! keyword, :id, :keyword
    json.category keyword.category.category
  end
end
