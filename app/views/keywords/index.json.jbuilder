json.keywords do
  json.array! @keywords do |keyword|
    json.extract! keyword, :id, :name
    json.category do
      json.id keyword.category.id
      json.name keyword.category.name
    end
  end
end
